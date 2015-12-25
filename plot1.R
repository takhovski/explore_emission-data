#load the data
setwd("c:/Users/Shobeir/Desktop/data/exp2/")
NEI <- readRDS(file = "summarySCC_PM25.rds")
SCC <- readRDS(file = "Source_Classification_Code.rds")
#load packages
library(dplyr)
# using pipline (chain) method group the data by year and then sum all possible sources
# store in the result
result <- NEI %>% group_by(year) %>% summarize(count=sum(Emissions))
### activate the png device and mention the size
png("plot1.png",width = 480,height = 480)
###plot the histogram and give a title's name and x axis label is corrected
plot(x=result$year,y=result$count,col = "red",main = "PM2.5 Trend in America",xlab="Year", ylab="Total PM2.5 Emmision From All Sources Between 1999-2008")
abline(lm(result$count~result$year)) # fit a linear trend line
### close the device to have a complete image.
dev.off()