#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#convert year and type to factors
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

#subset for Coal combustion sources

SCCcoal <- SCC[grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) | grepl("Lignite", SCC$SCC.Level.Three, ignore.case=TRUE),]
NEIcoal <- subset(NEI, SCC %in% SCCcoal$SCC)

#sum emissions per year for Coal sources

coalemissions <-(tapply(NEIcoal$Emissions, NEIcoal$year, sum))

#shape the dataframe for the plot

coal <- as.data.frame(matrix(ncol=2, nrow=4))
names(coal) = c("year", "emissions")
coal$year <- c("1999", "2002", "2005", "2008")
coal$emissions <- coalemissions

#plot emissions 

library(ggplot2)
ggplot(data=coal, aes(x=year, y=emissions, group=1)) + geom_line(colour = "red", size = 1) + geom_point() + ggtitle("Emissions per year from\ncoal combustion sources")


#copy plot to file

dev.copy(png, file="plot4.png")
dev.off()
