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

#create a data frame for the plot

motor <- as.data.frame(matrix(ncol=2, nrow=4))
names(motor) = c("year", "emissions")
motor$year <- c("1999", "2002", "2005", "2008")
motor$emissions <- motoremissions

#generate the plot

library(ggplot2)
ggplot(data=motor, aes(x=year, y=emissions, group=1)) + geom_line(colour = "blue", size = 1) + geom_point() + ggtitle("Emissions from Motor Vehicles\nin Baltimore City, MD")

#copy plot to file

dev.copy(png, file="plot5.png")
dev.off()