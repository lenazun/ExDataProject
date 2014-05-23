#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#convert year and type to factors
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

#subset motor vehicles for Baltimore City, MD and Los Angeles, CA

balmotor <- subset(NEI, NEI$type == "ON-ROAD" & NEI$fips == "24510")
lamotor <- subset(NEI, NEI$type == "ON-ROAD" & NEI$fips == "06037")

#sum emissions per year for motor vehicles for both cities

balmotoremissions <-(tapply(balmotor$Emissions, balmotor$year, sum))
lamotoremissions <-(tapply(lamotor$Emissions, lamotor$year, sum))

#create a data frame with the year by year change data

require(quantmod)

diff <- as.data.frame(matrix(ncol=3, nrow=8))
names(diff) = c("year", "city", "emissionschange")

diff$emissionschange[1:4] <- Delt(balmotoremissions)
diff$emissionschange[5:8] <- Delt(lamotoremissions)

diff$city[1:4] <- "Baltimore City"
diff$city[5:8] <- "Los Angeles"
diff$year <- c("1999", "2002", "2005", "2008")

diff$year <- as.factor(diff$year)
diff$city <- as.factor(diff$city)

#plot emissions to compare both cities

qplot(x=year, y=emissionschange, fill=city,
      data=diff, geom="bar", stat="identity",
      position="dodge")

#copy plot to file

dev.copy(png, file="plot6.png")
dev.off()