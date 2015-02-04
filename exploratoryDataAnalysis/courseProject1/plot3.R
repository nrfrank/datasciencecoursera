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
png(file = "plot3.png")

# Create plot with labels and add lines and legend.
plot(data$Time, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering",
     type = "n")
lines(data$Time, data$Sub_metering_1, col = "black")
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close graphics device.
dev.off()