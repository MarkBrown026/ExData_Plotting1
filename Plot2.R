

colsText <- readLines("household_power_consumption.txt", n=1)
rowsData <- grep("^1/2/2007|^2/2/2007", readLines("household_power_consumption.txt", n=2075259))

## Reading data in selection and name columns
dat2 <- read.table("household_power_consumption.txt", 
                                  header=F, sep=";", na.strings="?", 
                                  skip=rowsData[1]-1, nrows=length(rowsData),
                                  colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
names(dat2) <- unlist(strsplit(colsText, ";", fixed=T))


rm(colsText, rowsData)
electricConsumption$Date <- as.Date(dat2$Date, format="%d/%m/%Y")

##plot2 

png(filename = "plot2.png", bg = "transparent")
  plot(dat2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(dat2$Date)=="Friday")[1], nrow(dat2)+1))
dev.off()
