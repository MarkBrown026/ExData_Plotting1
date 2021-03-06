

colsText <- readLines("household_power_consumption.txt", n=1)
rowsData <- grep("^1/2/2007|^2/2/2007", readLines("household_power_consumption.txt", n=2075259))

## Read Data
dat3 <- read.table("household_power_consumption.txt", 
                                  header=F, sep=";", na.strings="?", 
                                  skip=rowsData[1]-1, nrows=length(rowsData),
                                  colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
names(dat3) <- unlist(strsplit(colsText, ";", fixed=T))

rm(colsText, rowsData)
dat3$Date <- as.Date(dat3$Date, format="%d/%m/%Y")

##plot3 
png(filename = "plot3.png", bg = "transparent")
  plot(dat3$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", xaxt="n")
  lines(dat3$Sub_metering_1)
  lines(dat3$Sub_metering_2, col="red")
  lines(dat3$Sub_metering_3, col="blue")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(dat3$Date)=="Friday")[1], nrow(dat3)+1))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()