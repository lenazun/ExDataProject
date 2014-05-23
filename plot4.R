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

#plot emissions 

colors = c("#ffffcc", "#c2e699", "#78c679","#238443")
barplot(coalemissions, yaxt="n", col = colors, border= NA, main = "Emissions per year from Coal Combustion sources", ylab="Total emissions")
axis(2, at=c(0e+00, 2e+05, 4e+05, 6e+05), labels=c(0,2,4,6))

#copy plot to file

dev.copy(png, file="plot4.png")
dev.off()
