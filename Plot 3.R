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
Sys.setlocale("LC_TIME","English")
data1$datetime_con <- strptime(paste(data1$Date,data1$Time),format = "%d/%m/%Y %H:%M:%S")
data1$datetime_con <- as.POSIXct(data1$datetime_con)
class(data1$datetime_con)
View(data1)

#Subset data to just the two days
data1_sub <- subset(data1, Date %in% c("1/2/2007","2/2/2007"))

###Plot 3
#Initialise the plot with sub-metering_1 (Black line)
# 1. Open png device
png("plot3.png", width=480, height=480)

# 2. Start the plot with Sub_metering_1 (Black line)
# We set the y-axis label and remove the x-axis label
plot(data1_sub$datetime_con, data1_sub$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")

# 3. Add Sub_metering_2 (Red line)
lines(data1_sub$datetime_con, data1_sub$Sub_metering_2, col="red")

# 4. Add Sub_metering_3 (Blue line)
lines(data1_sub$datetime_con, data1_sub$Sub_metering_3, col="blue")

# 5. Add the Legend
# 'lty=1' ensures the legend shows lines, not just colored boxes
legend("topright", 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1)

# 6. Close the device
dev.off()