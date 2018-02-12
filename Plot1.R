library(lubridate)

dat1 <- read.table("household_power_consumption.txt",header=TRUE, sep=";", 
                   stringsAsFactors=FALSE,
                   colClasses=c("character","character","numeric", "numeric","numeric","numeric","numeric"  ,"numeric","numeric"),
                   na.strings="?")

dat1$NewDate <- dmy(dat1$Date)

vector <- dat1$NewDate == ymd("2007-02-01") | dat1$NewDate == ymd("2007-02-02")
dat2 <- dat1[vector,]
rm(vector)
rm(dat1)


head(dat2)

png("plot1.png",width=480,height=480,units="px", bg="transparent", 
    type="cairo-png")

hist(dat2$Global_active_power, main="Global Active Power",
     col = "red", xlab="Global Active Power (kilowatts)")

dev.off()
