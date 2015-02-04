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
png(file = "plot4.png")

# Set up plotting area with two rows and columns (2 by 2).
par(mfrow = c(2,2))

# Add first plot. This is basically a copy of plot1.
# Adjusted the line weight to try to match example.
plot(data$Time, data$Global_active_power, xlab = "",
     ylab = "Global Active Power", type = "n")
lines(data$Time, data$Global_active_power, lwd = 0.5)

# Add second plot. Similarly adjust line weight. Hard to tell if it's correct.
plot(data$Time, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(data$Time, data$Voltage, lwd = 0.5)

# Add third plot. This is a copy of plot3.
plot(data$Time, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering",
     type = "n", lwd = 0.5)
lines(data$Time, data$Sub_metering_1, col = "black")
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Add fourth plot. Again adjusted line weight.
plot(data$Time, data$Global_reactive_power, xlab = "datetime", type = "n",
     ylab = "Global_reactive_power")
lines(data$Time, data$Global_reactive_power, lwd = 0.5)

# Close graphics device.
dev.off()