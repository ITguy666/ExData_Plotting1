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

###Plot 2 on time series for global active power

#Open png device
png("plot2.png",width=480,height=480)

#Plot time series and close device
plot(data1_sub$datetime_con,data1_sub$Global_active_power,type="l",xaxt="n",xlab="",ylab="Global Active Power (kilowatts)")
ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1,at=ticks,labels=c("Thu","Fri","Sat"))
dev.off()