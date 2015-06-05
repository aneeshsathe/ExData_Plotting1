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




# Plot 2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$DateTime,data$Global_active_power, type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()














