library(data.table)
library(chron)

# Read data, convert dates and times, and
# subset to just 2007-02-01 and 2007-02-02
dt <- fread('household_power_consumption.txt', na.strings="?")
dt[,Date:=as.Date(Date, format='%d/%m/%Y')]
dt <- dt[Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")]
dt[,Time:=chron(times=Time)]
dt[,DateTime:=as.POSIXct(paste(dt$Date, dt$Time), format="%Y-%m-%d %H:%M:%S")]

head(dt)

png('plot3.png', height=480, width=480)
plot(x=range(dt$DateTime), y=range(dt$Sub_metering_1, dt$Sub_metering_2, dt$Sub_metering_3), type="n",
     xlab="", ylab="Energy sub metering")
lines(x=dt$DateTime, y=dt$Sub_metering_1, col='black')
lines(x=dt$DateTime, y=dt$Sub_metering_2, col='red')
lines(x=dt$DateTime, y=dt$Sub_metering_3, col='blue')
legend("topright", lwd=1, col=c("black", "blue", "red"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
