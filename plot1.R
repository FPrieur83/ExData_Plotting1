library(dplyr)

# Read Data and convert date and time into R objects
dat <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dat$Date <- as.Date(dat$Date, '%d/%m/%Y')

# Extract only relevant data from the dates 2007-02-01 and 2007-02-02
dat.f <- filter(dat, Date >= '2007-02-01' & Date <= '2007-02-02')

# build histogram
par(mfrow = c(1,1))
hist(dat.f$Global_active_power, col = "red", breaks = 15, 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()