plot1 <- function()
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

#	plot1 is a histogram... 

	png("plot1.png",width=480,height=480)
	hist(smalldata$Global_active_power,
		col="red",
		main="Global Active Power",
		xlab="Global Active Power (kilowatts)",
		ylab="Frequency")

	dev.off()
}