plot3 <- function()
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

#	plot3 is an xy plot with three different data series for
#	the different sub metering values.  let's start with sub
#	meter one, then add the lines for 2 and 3...

	png("plot3.png",width=480,height=480)
	plot(smalldata$Time,
		smalldata$Sub_metering_1,
		col="black",
		type="l",
		xlab="",
		ylab="Energy sub metering")

#	add a line series for sub metering 2...

	lines(smalldata$Time,
		smalldata$Sub_metering_2,
		col="red")

#	and sub metering 3...

	lines(smalldata$Time,
		smalldata$Sub_metering_3,
		col="blue")

#	finally, we need a legend for this plot.  note that in order
#	to show the line colors in the legend, a line drawing argument
#	must be used...

	legend("topright",
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		col=c("black","red","blue"),
		lty="solid")

	dev.off()

}