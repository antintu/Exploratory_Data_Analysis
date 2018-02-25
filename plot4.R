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

png("plot4.png", width=480, height=480)
    
## Make 2x2 grid
par(mfrow=c(2,2))

## Plot the forth plot as png
# Plot a
plot(power_cons$dateTime, power_cons$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot b
plot(power_cons$dateTime,power_cons$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot c
plot(power_cons$dateTime, power_cons$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_cons$dateTime, power_cons$Sub_metering_2, col="red")
lines(power_cons$dateTime, power_cons$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot d
plot(power_cons$dateTime, power_cons$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


dev.off()