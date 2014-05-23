#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#convert year to factors
NEI$year <- as.factor(NEI$year)

#add the emissions per year for Baltimore

baltonly <- subset(NEI, NEI$fips == 24510)
baltemissions <- (tapply(baltonly$Emissions, baltonly$year, sum))

#plot emissions in a barplot

colors = c("#ffffcc", "#a1dab4", "#41b6c4","#225ea8")
barplot(baltemissions, col = colors, border = NA, main = "Emissions per year in Baltimore City, MD", ylab="Total emissions")

#copy plot to file

dev.copy(png, file="plot2.png")
dev.off()


