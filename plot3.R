##Note: This R script creates the third plot ("Plot 3") of the Coursera Exploratory Data Analysis Course
##   Week 1 Peer-graded Assignment.

##Before doing anything, ensure that your working directory is set properly.  Uncomment the two (2)
##     lines of code below to do so.
#getwd()
#setwd("C:\\Users\\bcoon\\Desktop\\Files\\Coursera\\")

##If you haven't downloaded and unzipped the data file to the /data subdirectory in your 
##   working directory, uncomment the lines of code between the ##-----/ /-----/ lines below
##   to do so now. (NOTE: Lines beginning with two [2] pound signs [##] are commnets that should
##   remain as such.)

##---------------------------------------/ BEGIN DATA DOWNLOAD CODE SECTION /--------------------/

#dirName <- "./Data"
#if(!file.exists(dirName)){dir.create(dirName)}

##  Create the .zip file download path variable
#fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##  We'll rename the file when downloading it
#fileName <- "./data/HouseHoldPowerConsumptionDataset.zip"

##  Now download and rename the zipped datafile.
#download.file(fileUrl,destfile=fileName)

##  Next step, unzip the data file to the ./Data directory and rename it
#unzip(zipfile=fileName,exdir=dirName)
#dir("./Data")

#---------------------------------------/ END DATA DOWNLOAD CODE SECTION /--------------------/

#Open up the unzipped, downloaded house power dataset for use.
HousePowerDataFile <- "./data/household_power_consumption.txt"
HousePowerData <- read.table(HousePowerDataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

##   We'll be using the dplyr library for this script.  If it's not installed, download and install it.
library(dplyr)

## First, let's extract only the data for the dates specified in the assignment to analyze.
SubsetHousePowerData <- filter(HousePowerData, Date %in% c("1/2/2007","2/2/2007"))

## Uncomment the line immediately below to inspect the data if desired.
#str(SubsetHousePowerData)

## Create a new date/time variable with the combined date & time information, formatted accordingly.
SubsetHousePowerData$dateAndTime <- strptime(paste(SubsetHousePowerData$Date, 
                                              SubsetHousePowerData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

##First, open the PNG device for writing the graph to it.
png(file= "plot3.png", width = 480, height = 480)

##Grab the legend names from the appropriate data subset column names
the_legend <- colnames(SubsetHousePowerData)[7:9]

##Create labels for the Y axis
y_label <- "Energy sub metering"

##Create the plot (R will automatically write it to the working directory.)
with(SubsetHousePowerData, plot(dateAndTime, Sub_metering_1, type = "l", xlab = "", ylab = y_label))
with(SubsetHousePowerData, lines(dateAndTime, Sub_metering_2, col = "red"), type = "l")
with(SubsetHousePowerData, lines(dateAndTime, Sub_metering_3, col = "blue"), type = "l")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = the_legend)

##Now, close the png device.
dev.off()
