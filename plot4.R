library(dplyr)

# Read Data and convert date and time into R objects
dat <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dat$Date <- as.Date(dat$Date, '%d/%m/%Y')

# Extract only relevant data from the dates 2007-02-01 and 2007-02-02
dat.f <- filter(dat, Date >= '2007-02-01' & Date <= '2007-02-02')
dat.f <- mutate(dat.f, weekday = weekdays(dat.f$Date))
dat.f <- mutate(dat.f, date.time = as.POSIXct(paste(dat.f$Date, dat.f$Time), 
                                              format="%Y-%m-%d %H:%M:%S"))

# Set device and paramters
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4, 4, 1, 1), oma = c(1, 1, 1, 1))

# plot graph 1
plot(dat.f$date.time, dat.f$Global_active_power, pch = 20,
     ylab = "Global Active Power (kilowatts)", xlab = "", type="n")
lines(dat.f$date.time, dat.f$Global_active_power)

# plot graph 2
plot(dat.f$date.time, dat.f$Voltage, pch = 20,
     xlab = "datetime", ylab = "Voltage", type="n")
lines(dat.f$date.time, dat.f$Voltage)

# plot graph 3
plot(dat.f$date.time, dat.f$Global_active_power, pch = 20,
     ylab = "Energy sub metering", xlab = "", ylim=c(0, 40), type="n")
lines(dat.f$date.time, dat.f$Sub_metering_1)
lines(dat.f$date.time, dat.f$Sub_metering_2, col = "red")
lines(dat.f$date.time, dat.f$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

# plot graph 4
plot(dat.f$date.time, dat.f$Global_reactive_power, pch = 20,
     xlab = "datetime", ylab = "Global_reactive_power", ylim=c(0, 0.5), type="n",
     yaxt="n")
lines(dat.f$date.time, dat.f$Global_reactive_power)
ylbl <- c(0, 0.1, 0.2, 0.3, 0.4, 0.5)
axis(2,at=ylbl, label=ylbl)

dev.off()