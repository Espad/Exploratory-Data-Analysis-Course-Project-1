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

#plot 2
plot(data$Global_active_power ~ data$Datetime, ylab = "Global Active Power (kilowatts)", type = "l", xlab = "")

# save plot as *.png file
dev.copy(png,"plot2.png", units="px", width=480, height=480)
dev.off()

#clean environment
rm(data)
close(fileConnection)
