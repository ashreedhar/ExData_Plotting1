# Coursera - Datascience - Exploratory Data Analysis
# Course Project 1
# Plot 4
# Date:   11/07/2015
# Author: ashreedhar
# ------------------------------------------------------------------------------

# Download and unzip the raw data
src_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dstFile = "household_power_consumption.zip"
download.file(url = src_url, destfile = dstFile)
unzip(dstFile, exdir=getwd())

# Read in the file if not already read in
if (!exists("proj1Dat") )
{
  filename <- "household_power_consumption.txt"
  proj1Dat <- read.table(file = filename, header = TRUE, sep = ";", as.is = TRUE)
} 

# Extract rows for data sampled on 2007-02-01 and 2007-02-02
plotDat = subset(proj1Dat, subset = (  proj1Dat$Date == "1/2/2007" | 
                                         proj1Dat$Date == "2/2/2007"))

# Extract rows for data sampled on 2007-02-01 and 2007-02-02
plotDat = subset(proj1Dat, subset = (  proj1Dat$Date == "1/2/2007" | 
                                         proj1Dat$Date == "2/2/2007"))

# Add a column to represent the posix date and time for each observation
plotDat$posixTime <- strptime( paste(plotDat$Date, plotDat$Time), format = "%d/%m/%Y %H:%M:%S")

# Plot a histogram of the global active power for the chosen dates
png(file = "plot4.png", width=480, height=480, units="px")  # open a png file

# Set page layout for multiple plots
par( mfrow=c(2,2))

with( plotDat, {
  #---------------------
  # Top left plot
  plot(plotDat$posixTime, as.numeric(plotDat$Global_active_power), 
       xlab="", ylab="Global Active Power" , type = "n")
  lines(plotDat$posixTime, as.numeric(plotDat$Global_active_power))
  
  #---------------------
  # Top right plot
  plot(plotDat$posixTime, as.numeric(plotDat$Voltage), 
       xlab="datetime", ylab="Voltage" , type = "n")
  lines(plotDat$posixTime, as.numeric(plotDat$Voltage))
  
  #---------------------
  # Bottom left plot
  # Set up the plot: x and y axes
  plot( plotDat$posixTime, as.numeric(plotDat$Sub_metering_1), type = "n", xlab="", ylab="Energy sub metering")
  
  # plot sub metering 1: kitchen - dishwasher, microwave, oven
  lines(plotDat$posixTime, as.numeric(plotDat$Sub_metering_1), col="black")
  
  # plot sub metering 2: laundry - washer, dryer, refridgerator, light
  lines(plotDat$posixTime, as.numeric(plotDat$Sub_metering_2), col="red")
  
  # plot sub metering 3: water-heater, air-conditioner
  lines(plotDat$posixTime, as.numeric(plotDat$Sub_metering_3), col="blue")
  legend( "topright", lty = 1, col=c("black", "red", "blue"), 
          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.75, bty="n")
  
  #---------------------
  # Bottom right plot
  plot(plotDat$posixTime, as.numeric(plotDat$Global_reactive_power), 
       xlab="datetime", ylab="Global_reactive_power" , type = "n")
  lines(plotDat$posixTime, as.numeric(plotDat$Global_reactive_power))
})

dev.off()  # close the png file