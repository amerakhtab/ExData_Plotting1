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
png(file = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power")
dev.off()