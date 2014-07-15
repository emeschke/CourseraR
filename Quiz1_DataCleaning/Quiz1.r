library(XML)
library(data.table)

#Question 1, import the data and find the number of houses values > 999999

#Download the file, need to provide the URL and the destination file
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', 'C:/Users/E/Desktop/RCoursera/Quiz1_DataCleaning/idaho_data.csv' )

#Read the data using read.csv
my_data <- read.csv('C:/Users/E/Desktop/RCoursera/Quiz1_DataCleaning/idaho_data.csv')

#Set a logical operator to make a logical data set where VAL = 24
L = my_data$VAL == 24

#Count the "trues" in the logical vector, removing na's
sum(L, na.rm = T)

#Question 3, from the url below, read in only lines 18-23, cols 7-15 
#Won't read in properly
#download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', 'C:/Users/E/Desktop/RCoursera/Quiz1_DataCleaning/natgas_data.csv', method = 'internal', mode = 'wb')
#nat_data <- read.table('C:/Users/E/Desktop/RCoursera/Quiz1_DataCleaning/natgas_data.csv')

#Question 4, from the xml link below, count number of restaurants with zipcode 21231
#Set the file URL
fileURL<- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

#Read in the doc using the XML library
doc <- xmlTreeParse(fileURL, useInternal = TRUE)

#Get the root node and extract the xmlName
rootNode <- xmlRoot(doc)
xmlName <- rootNode

#Get the zips into a list
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)#Count the number of zipcodes that match 21231 and return the sum (127)
Lz = zips == "21231"
sum(Lz)

#Question 5.  
#Read in the URL
URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv" 
file = 'C:/Users/E/Desktop/RCoursera/Quiz1_DataCleaning/acs_data.csv'
download.file(URL , file )

#Read the file into a data table
DT = fread(file)

#Different ways to calculate the average.
DT[,mean(pwgtp15),by=SEX]
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
tapply(DT$pwgtp15,DT$SEX,mean)
mean(DT$pwgtp15,by=DT$SEX)