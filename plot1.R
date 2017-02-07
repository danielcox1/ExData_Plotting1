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

png('plot1.png', height=480, width=480)
hist(dt$Global_active_power, main="Global Active Power", col="red",
     xlab="Global Active Power (kilowatts)")
dev.off()
