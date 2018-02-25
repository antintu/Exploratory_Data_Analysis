library("data.table")
setwd("~/Documents/Andrei/Werk/Cursusen/Data science Johns Hopkins/Files")

#Reading the correct data as data.table
power_cons <- data.table::fread(input = "household_power_consumption.txt"
                                , na.strings="?"
)

# No scientific annotation in histogram
power_cons[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Graphing by time of day
power_cons[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering Dates ffor 2007-02-01 and 2007-02-02
power_cons <- power_cons[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

## Plot the third plot as png
plot(power_cons$dateTime, power_cons$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_cons$dateTime, power_cons$Sub_metering_2,col="red")
lines(power_cons$dateTime, power_cons$Sub_metering_3,col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()