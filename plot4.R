library(dplyr)

#Reading the data
Elec_consume <- read.csv2("./exdata_data_household_power_consumption/household_power_consumption.txt", 
                          na.strings = "?", stringsAsFactors = FALSE)

#Combining Date and Time and filtering
Elec_consume <- mutate(Elec_consume, Date.Time=paste(Elec_consume$Date, Elec_consume$Time))
Elec_consume$Date.Time <- strptime(Elec_consume$Date.Time, format = "%d/%m/%Y %H:%M:%S")
data <- Elec_consume %>% select(-Date,-Time)
data$Date.Time <- as.POSIXct(data$Date.Time)
data <- data %>% filter(Date.Time >= "2007-02-01" & Date.Time < "2007-02-03")

data$Global_active_power <- as.numeric(data$Global_active_power)

#Creating the plot using png device
png(file = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

#1
plot(data$Date.Time,data$Global_active_power, type = "l", lty=1, 
     ylab = "Global Active Power", xlab = "")

#2
with(data, plot(Date.Time, Sub_metering_1, type = "n", ylab = "Energy sub metering",
                xlab = ""))
with(data, lines(Date.Time, Sub_metering_1))
with(data, lines(Date.Time, Sub_metering_2, col="red"))
with(data, lines(Date.Time, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#3
plot(data$Date.Time,data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#4
plot(data$Date.Time,data$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()