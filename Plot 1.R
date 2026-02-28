install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)

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
Sys.setlocale("LC_TIME","English")
data1$datetime_con <- strptime(paste(data1$Date,data1$Time),format = "%d/%m/%Y %H:%M:%S")
data1$datetime_con <- as.POSIXct(data1$datetime_con)
class(data1$datetime_con)
View(data1)

#Subset data to just the two days
data1_sub <- subset(data1, Date %in% c("1/2/2007","2/2/2007"))

###Plot 1 on histogram 

# Open png device
png("plot1.png",width=480, height=480)

#Create histogram and close device
hist(data1_sub$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()


