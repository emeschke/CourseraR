mydata = read.csv("hw1_data.csv")  # read csv file 

#Print header
colnames(mydata)

#Print first two rows
mydata[c(1,2),]

#Print last two rows
tail(mydata, n=2)

#Print 47th row to check value of ozone
mydata[c(47),]

#Count na values in ozone
sum(is.na(mydata[,1])) 

#Get the summary of the data
summary(mydata)

#Get the mean of the data, explicity removing is.na
sapply(mydata, mean, na.rm=TRUE)

#Extract a subset of the data based on Ozone>31, temp>90
mydata_filt <- subset(mydata, Ozone > 31 & Temp>90)

#Get the mean of that data
summary(mydata_filt)

#Get the mean of the temp in month == 6
summary(subset(mydata, Month == 6))

#Get the max ozone value when month == 5
summary(subset(mydata, Month == 5))
