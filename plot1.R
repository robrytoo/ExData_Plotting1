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

# Plot 1
xData <- as.numeric(df$globalactivepower)  
# Missing values "?" will be coerced to NA

png(file="plot1.png", height=480, width=480)
par(oma=c(1,1,1,1))
hist(xData, col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()  #close png

