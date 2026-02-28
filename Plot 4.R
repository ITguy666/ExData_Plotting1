setwd("C:/Users/cleme/OneDrive/Desktop/Coursera")
#Define file name and url
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "Powerconsumptiondataset.zip"

#Download the file and unzip file
download.file(url,destfile=zipfile,method="curl")
unzip(zipfile)

# Read the txt file
data1 <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
View(data1)
names(data1)
dim(data1)
head(data1)

#Convert to Date functions
Sys.setlocale("LC_TIME","C")
data1$datetime_con <- strptime(paste(data1$Date,data1$Time),format = "%d/%m/%Y %H:%M:%S")
data1$datetime_con <- as.POSIXct(data1$datetime_con)
class(data1$datetime_con)
View(data1)

#Subset data to just the two days
data1_sub <- subset(data1, Date %in% c("1/2/2007","2/2/2007"))


### Plot 4

# 1. Open the PNG device
png("plot4.png", width=480, height=480)

# 2. Set the layout to 2 rows and 2 columns
par(mfrow = c(2, 2))

# --- TOP LEFT: Global Active Power (Similar to Plot 2) ---
plot(data1_sub$datetime_con, data1_sub$Global_active_power, 
     type="l", xaxt="n",xlab="", ylab="Global Active Power")
ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1,at=ticks,labels=c("Thu","Fri","Sat"))

# --- TOP RIGHT: Voltage ---
plot(data1_sub$datetime_con, data1_sub$Voltage, 
     type="l", xaxt="n",xlab="datetime", ylab="Voltage")
ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1,at=ticks,labels=c("Thu","Fri","Sat"))

# --- BOTTOM LEFT: Energy Sub Metering (Similar to Plot 3) ---
plot(data1_sub$datetime_con, data1_sub$Sub_metering_1, type="l", xaxt="n",xlab="", ylab="Energy sub metering")
ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1,at=ticks,labels=c("Thu","Fri","Sat"))
lines(data1_sub$datetime_con, data1_sub$Sub_metering_2, col="red")
lines(data1_sub$datetime_con, data1_sub$Sub_metering_3, col="blue")
# Note: bty="n" removes the border around the legend, making it fit better in a small pane
legend("topright", col=c("black", "red", "blue"), lty=1, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# --- BOTTOM RIGHT: Global Reactive Power ---
plot(data1_sub$datetime_con, data1_sub$Global_reactive_power, 
     type="l", xaxt="n",xlab="datetime", ylab="Global_reactive_power")
ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1,at=ticks,labels=c("Thu","Fri","Sat"))

# 3. Close the device
dev.off()