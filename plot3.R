#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#convert year and type to factors
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

#Subset for Baltimore City, MD

baltonly <- subset(NEI, NEI$fips == 24510)

#sum emissions per year

aggregated <- aggregate(baltonly[,4], by =list(baltonly[,5], baltonly[,6]), FUN = sum)
colnames(aggregated)[1:3] <- c("type", "year", "emissions")

#plot emissions using ggplot2

library(ggplot2)
qplot(x = year, y= emissions, data = aggregated, geom = "bar", stat="identity", facets = .~ type)   

#copy plot to file

dev.copy(png, file="plot3.png")
dev.off()