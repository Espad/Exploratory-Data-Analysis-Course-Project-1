# Please ensure household_power_consumption.txt is in the working directory
fileConnection <- file("household_power_consumption.txt")

# setting standard locale, because my system locale is russian1251 and after converting dates i get days of week in
# russian, not in english 
Sys.setlocale("LC_TIME", "C")

# read data with parsing lines, for getting only 1,2 february of 2007 year
data <- read.table(text = grep("^[1,2]/2/2007",readLines(fileConnection), value = TRUE), 
col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
sep = ";", header = TRUE, na.strings = "?")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

# plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data,{
  plot(Global_active_power ~ Datetime, ylab = "Global Active Power", type = "l", xlab = "")
  plot(Voltage ~ Datetime, ylab = "Voltage", xlab = "datetime", type = "l")
  plot(Sub_metering_1 ~ Datetime, ylab = "Energy sub metering", xlab = "", type = "l")
  lines(Sub_metering_2 ~ Datetime, col = "red")
  lines(Sub_metering_3 ~ Datetime, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n", cex=0.75,
         legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "))
  plot(Global_reactive_power ~ Datetime, ylab = "Global_reactive_power", xlab = "datetime",  type = "l")
  
})

# save plot as *.png file
dev.copy(png,"plot4.png", units="px", width=480, height=480)
dev.off()

#clean environment
rm(data)
close(fileConnection)
