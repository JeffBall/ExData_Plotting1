plot4 <- function()
{
#	the first section of code will always be the same; read
#	the data table from the text file.  note that semicolons
#	are used as delimiters in the file and NA values are stored
#	as '?'.  Headers are included in the file.

	filename <- "household_power_consumption.txt"
	plotdata <- read.table(filename,header=TRUE,sep=";",na.strings="?")

#	now we need to convert the date and time columns from factors
#	to actual dates and times.  note that i'm first going to create
#	a character variable called 'Stamp' which concatenates the date
#	and time...

	plotdata$Stamp <- paste(as.character(plotdata$Date),
		as.character(plotdata$Time))

	plotdata$Date <- as.Date(plotdata$Stamp,format="%d/%m/%Y")
	plotdata$Time <- strptime(plotdata$Stamp,"%d/%m/%Y %H:%M:%S")

#	now let's get a smaller data set just based on the two days
#	of data we want to plot...

	smalldata <- plotdata[plotdata$Date=="2007-02-01" |
		plotdata$Date=="2007-02-02",]

#	from here, the code will be changed based on the plot we want
#	to create...

#	plot4 is a 2x2 panel of various plots.  the two in the left
#	column have already been created, so let's set up the plotting
#	using col and reuse code from the other scripts to build them...

	png("plot4.png",width=480,height=480)
	par(mfcol=c(2,2))

#	now get the plot from plot2...

	plot(smalldata$Time,
		smalldata$Global_active_power,
		col="black",
		type="l",
		xlab="",
		ylab="Global Active Power (kilowatts)")

#	and the plot from plot3...

	plot(smalldata$Time,
		smalldata$Sub_metering_1,
		col="black",
		type="l",
		xlab="",
		ylab="Energy sub metering")

	lines(smalldata$Time,
		smalldata$Sub_metering_2,
		col="red")

	lines(smalldata$Time,
		smalldata$Sub_metering_3,
		col="blue")

	legend("topright",
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		col=c("black","red","blue"),
		lty="solid")

#	now we just need two more simple plots in the same fashion as
#	plot2 but using voltage and global reactive power...

	plot(smalldata$Time,
		smalldata$Voltage,
		col="black",
		type="l",
		xlab="datetime",
		ylab="Voltage")

	plot(smalldata$Time,
		smalldata$Global_reactive_power,
		col="black",
		type="l",
		xlab="datetime",
		ylab="Global_reactive_power")

	dev.off()

}