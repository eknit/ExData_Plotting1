#Read in data

directory <- # Working directory
setwd(directory) #Set working directory

#Read in initial data set to get column classes
initial <- read.table("household_power_consumption.txt", nrows=100, na.strings="?", sep=";", header=T)
classes <- sapply(initial, class)

#Read in full dataset
data <- read.table("household_power_consumption.txt", colClasses=classes, na.strings="?", sep=";", header=T)

# Assign date and time to date/time classes
data$Date <- as.Date(data$Date, "%d/%m/%Y")
sub <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]
datetime <- strptime(paste(sub$Date, sub$Time), "%d/%m/%Y %H:%M:%S")

#Plot 3
png(
  "plot3.png",
  width     = 480,
  height    = 480,
  units     = "px",
)
plot(sub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n")
lines(sub$Sub_metering_2, col="red")
lines(sub$Sub_metering_3, col="blue")
xat = c((1:length(sub$Time))[sub$Time=="00:00:00"], length(sub$Time)+1)
axis(1, at=xat, labels=c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()