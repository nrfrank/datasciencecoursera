# Open a connection to the file, download it, and unzip/load the data.
if (!exists("data")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?", 
                     col.names = c("Date", "Time", "Global_active_power",
                                   "Global_reactive_power", "Voltage",
                                   "Global_intensity", "Sub_metering_1", 
                                   "Sub_metering_2", "Sub_metering_3"),
                     colClasses = c("character", "character","numeric", "numeric",
                                    "numeric", "numeric", "numeric", "numeric",
                                    "numeric"), nrows = 2880, skip = 66636)
  unlink(temp)
  
  # Change the "Date" column data type to Date and "Time" to POSIXlt.
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
}

# Open png graphics device.
png(file = "plot2.png")

# Create and append lines to the plot.
plot(data$Time, data$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type = "n")
lines(data$Time, data$Global_active_power)

# Close graphics device.
dev.off()