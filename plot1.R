#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#convert year to factors
NEI$year <- as.factor(NEI$year)

#add the emissions per year

allemissions <-(tapply(NEI$Emissions, NEI$year, sum))

#plot emissions in a barplot

colors = c("#edf8fb", "#b3cde3", "#8c96c6","#88419d")
barplot(allemissions, yaxt="n", col = colors,  border = NA, main = "Emissions per year", ylab="Total emissions")
axis(2, at=c(0, 2e+06, 4e+06, 6e06, 8e06), labels=c(0,2,4,6,8))

#copy plot to file

dev.copy(png, file="plot1.png")
dev.off()


