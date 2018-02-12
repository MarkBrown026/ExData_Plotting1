colsText <- readLines("household_power_consumption.txt", n=1)
rowsData <- grep("^1/2/2007|^2/2/2007", readLines("household_power_consumption.txt", n=2075259))

dat4 <- read.table("household_power_consumption.txt", 
                                  header=F, sep=";", na.strings="?", 
                                  skip=rowsData[1]-1, nrows=length(rowsData),
                                  colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
names(dat4) <- unlist(strsplit(colsText, ";", fixed=T))


rm(colsText, rowsData)
dat4$Date <- as.Date(dat4$Date, format="%d/%m/%Y")

#plot4 - set of graphs
png(filename = "plot4.png", bg = "transparent")
  par(mfrow = c(2, 2))
  plot(dat4$Global_active_power, type="l", ylab="Global Active Power", xlab="", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(dat4$Date)=="Friday")[1], nrow(dat4)+1))

  plot(dat4$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(dat4$Date)=="Friday")[1], nrow(dat4)+1))

  plot(dat4$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", xaxt="n")
  lines(dat4$Sub_metering_1)
  lines(dat4$Sub_metering_2, col="red")
  lines(dat4$Sub_metering_3, col="blue")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(dat4$Date)=="Friday")[1], nrow(dat4)+1))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

  plot(dat4$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(dat4$Date)=="Friday")[1], nrow(dat4)+1))
dev.off()