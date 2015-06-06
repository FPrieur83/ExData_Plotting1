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
png(file = "plot2.png", width = 480, height = 480)
par(mfrow = c(1,1))

# build chart
plot(dat.f$date.time, dat.f$Global_active_power, pch = 20,
     ylab = "Global Active Power (kilowatts)", xlab = "", type="n")
lines(dat.f$date.time, dat.f$Global_active_power)

dev.off()