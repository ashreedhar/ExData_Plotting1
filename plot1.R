# ------------------------------------------------------------------------------
# Coursera - Datascience - Exploratory Data Analysis
# Course Project 1
# Plot 1
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
png(file = "plot1.png", width=480, height=480, units="px")  # open a png file
hist( as.numeric(plotDat$Global_active_power), 
      col="red", 
      # Label the x axis
      xlab = "Global Active Power (kilowatts)", 
      # Set title
      main = "Global Active Power")
dev.off()  # close the png file