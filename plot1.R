library("data.table")
setwd("~/Documents/Andrei/Werk/Cursusen/Data science Johns Hopkins/Files")

#Reading the correct data as data.table
power_cons <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# No scientific annotation in histogram
power_cons[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changing Date Column to Date Type
power_cons[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filtering Dates for 2007-02-01 and 2007-02-02
power_cons <- power_cons[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot the first plot as png
hist(power_cons[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()