#Check if the working directory already contains the data_set; "household_power_consumption.txt"
if(!file.exists("household_power_consumption.txt")){

fileURl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURl, destfile = "./energy_data.zip")
unzip(zipfile = "./energy_data.zip", exdir = ".")
unlink("energy_data.zip")

#In case the energy data-set has already been downloaded, unzipped and saved in the current working directory,
#the user is being informed about it via a message box
} else { 
  
  message("The corresponding data-set is available in the current working directory.")
  
}

#Load relevant data (from 01/02/2007 till 02/02/2007) and set date- and time-formats
energy_data <- read.table(file = "household_power_consumption.txt", 
                          sep = ";",
                          header = F,
                          col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                          skip = grep("1/2/2007", readLines("household_power_consumption.txt")),
                          colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric"),
                          nrows = 2880,
                          na.strings = "?")

energy_data$Date <- as.Date(energy_data$Date, format = "%d/%m/%Y")
energy_data$Time <- strptime(energy_data$Time, format = "%H:%M:%S")

#Plotting the corresponding graf and saving it as a .png file
png(filename = "plot1.png",
    width = 480, 
    height = 480, 
    units = "px",
    bg = "white")

  hist(x = energy_data$Global_active_power, 
       breaks = 12,
       col = "red",
       main = "Global Active Power",
       xlab = "Global Active Power (in kilowatts)")

dev.off()