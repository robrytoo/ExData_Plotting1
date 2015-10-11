# Read power consumption data and generate plot in png file.
# The data file must reside in a subdirectory "./data" of the working director
# The data is downloaded from
# "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# data file is "household_power_consumption.txt"

#read data file
filedir <- "./data"
datafile <- "household_power_consumption.txt"
filepath <- paste(filedir, datafile, sep="/")
df <- read.table(filepath, sep=";", header = TRUE, stringsAsFactors=F)

#Convert to lower case column names
names(df) <- tolower(gsub("_", "", names(df)))

#Extract records from only 2/1/2007 and 2/2/2007
df$date <- as.Date(df$date, "%d/%m/%Y")
dateLimit = as.Date(c("20070201","20070202"), "%Y%m%d")
df <- df[df$date == dateLimit[1] | df$date == dateLimit[2],]

#Plot 4
png(file="plot4.png", height=480, width=480)
par(oma=c(1,1,1,1), mfcol=c(2,2))

#plot top left
yData <- as.numeric(df$globalactivepower)  
# Missing values "?" will be coerced to NA
xData <- 1:length(yData)
plot(xData, yData, type="l", axes=F, 
     xlab="", ylab="Global Active Power")
box(which="plot")
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"), pos=-0.07)
axis(2, at= c(0, 2, 4, 6), pos=-115)

#plot bottom left
yCols <- df[,as.numeric(c(7:9))]
xData <- 1:dim(yCols)[1]
plot(xData,as.numeric(yCols[,1]), type="n", axes=F,
     xlab="", ylab="Energy sub metering")
lines(xData,as.numeric(yCols[,1]), type="l", col="black")
lines(xData,as.numeric(yCols[,2]), type="l", col="red")
lines(xData,as.numeric(yCols[,3]), type="l", col="blue")
box(which="plot")
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"), pos=-1.5)
axis(2, at= c(0, 10, 20, 30), pos=-115)
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.82,
       lty=c(1,1,1), col=c("black", "red", "blue"), bty="n") 

#plot top right
yData <- as.numeric(df$voltage)  
# Missing values "?" will be coerced to NA
xData <- 1:length(yData)
plot(xData, yData, type="l", axes=F, 
     xlab="datetime", ylab="Voltage")
box(which="plot")
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"), pos=232.5)
axis(2, at= c(234, 238, 242, 246), pos=-115)

#plot bottom right
yData <- as.numeric(df$globalreactivepower)  
# Missing values "?" will be coerced to NA
xData <- 1:length(yData)
plot(xData, yData, type="l", axes=F, 
     xlab="datetime", ylab="Global_reactive_power")
box(which="plot")
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"), pos=-0.02)
axis(2, at=seq(0,0.5,by=0.1), pos=-115)

dev.off()

