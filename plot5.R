#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#convert year and type to factors
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

#subset for motor vehicle sources

NEImotor <- subset(NEI, NEI$type == "ON-ROAD")

#subset for Baltimore City, MD

baltmotor <- subset(NEImotor, NEImotor$fips == 24510)

#sum emissions per year for motor vehicles

motoremissions <-(tapply(baltmotor$Emissions, baltmotor$year, sum))

#plot emissions 

colors = c("#ffffb2", "#fecc5c", "#fd8d3c","#e31a1c")
barplot(motoremissions, col = colors, border = NA, main = "Emissions from Motor Vehicles in Baltimore City, MD", ylab="Total emissions")

#copy plot to file

dev.copy(png, file="plot5.png")
dev.off()