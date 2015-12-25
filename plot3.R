#load the data
setwd("c:/Users/Shobeir/Desktop/data/exp2/")
NEI <- readRDS(file = "summarySCC_PM25.rds")
SCC <- readRDS(file = "Source_Classification_Code.rds")
#load packages
library(dplyr)
library(ggplot2)
# using pipline (chain) method group the data by year and then sum all possible sources
# store in the result
NEI <- tbl_df(NEI) # so it prints a little nicer
result <- NEI %>% filter(NEI$fips == "24510") %>% group_by(year,type) %>% summarize(count=sum(Emissions))
### activate the png device and mention the size
png("plot3.png",width = 480,height = 480)
###plot the histogram and give a title's name and x axis label is corrected
qplot(x=result$year,y=result$count,col = as.factor(result$type),
      main = "PM2.5 Trend in Baltimore City, MD",xlab="Year", 
      ylab="Total PM2.5 Emmision From different Sources Between 1999-2008",
      geom = c("point")) + geom_smooth(method = "lm")
### close the device to have a complete image.
dev.off()