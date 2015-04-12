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

#Plot 1
png(
  "plot1.png",
  width     = 480,
  height    = 480,
  units     = "px",
  type="cairo"
)
hist(sub$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()

