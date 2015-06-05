rm(list = ls())

date_data <- read.table(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"),  header=T,sep=";",
                        colClasses = c("factor", rep("NULL", 8)))
date_data$Date=as.Date(date_data$Date,"%d/%m/%Y")


in_rows=which(c(date_data$Date>=as.Date("2007-02-01","%Y-%m-%d")&c(date_data$Date<=as.Date("2007-02-02","%Y-%m-%d"))))
len_rows=length(in_rows)

data <- read.table(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), 
                   skip = in_rows[1]-1,
                   nrows=len_rows, header=T,sep=";",na.strings="?")

data_head <- read.table(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), 
                        nrows=1, header=T,sep=";" )
colnames(data)=colnames(data_head)

data=cbind(data.frame(DateTime=paste(data$Date,data$Time)),data)
data$DateTime=strptime(data$DateTime,"%d/%m/%Y %H:%M:%S")



# Plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(x<-data$DateTime,data$Sub_metering_1, type="l",ylab="Energy sub metering",xlab="",col="black")
lines(x,data$Sub_metering_2,col="red")
lines(x,data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=2)
dev.off()














