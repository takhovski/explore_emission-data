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
SCC <- tbl_df(SCC) # so it prints a little nicer
wanted <- filter(SCC, grepl("Coal",Short.Name)) # make a smaller dataset
rm(SCC) # free up some memory by removing the SCC dataset
desired_SCC <- wanted$SCC # list of wanted SCC numbers that contain Coal
### group the data set by year then filter the Coal related columns and counts the emissions
result <- NEI %>% group_by(year) %>% filter(SCC %in% desired_SCC) %>% summarize(count=sum(Emissions))
### activate the png device and mention the size
png("plot4.png",width = 480,height = 480)
###plot the histogram and give a title's name and x axis label is corrected
qplot(x=result$year,y=result$count,
      main = "Coal-related Emissions in America",xlab="Year", 
      ylab="Total PM2.5 Emmision (tons)",
      geom = c("point")) + geom_smooth(method = "lm")
### close the device to have a complete image.
dev.off()