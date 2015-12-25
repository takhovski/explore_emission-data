#load the data
setwd("c:/Users/Shobeir/Desktop/data/exp2/")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# SCC <- readRDS(file = "Source_Classification_Code.rds")
#load packages
library(dplyr)
library(ggplot2)
# using pipline (chain) method filter based on Conditions, group the data by year, and then sum all possible sources
# store in the result
NEI <- tbl_df(NEI) # so it prints a little nicer

Baltimore <- NEI %>% filter(NEI$fips == "24510" , NEI$type == "ON-ROAD") 
LA <- NEI %>% filter(NEI$fips == "06037" , NEI$type == "ON-ROAD") 

### Give more Descriptive names
Baltimore$fips <- gsub("24510","Baltimore",Baltimore$fips)
LA$fips <- gsub("06037","LA",LA$fips)
### grouping LA and Baltimore results and Normalizing the data to be comparable with the other city
### Baltimore
result_Baltimore <- Baltimore %>% group_by(year,fips) %>% summarize(count=sum(Emissions))
min_Baltimore <- min(result_Baltimore$count)
max_Baltimore <- max(result_Baltimore$count)
result_Baltimore <- mutate(result_Baltimore,normalized_emission = (count-min_Baltimore)/(max_Baltimore-min_Baltimore))
### LA
result_LA <- LA %>% group_by(year,fips) %>% summarize(count=sum(Emissions))
min_LA <- min(result_LA$count)
max_LA <- max(result_LA$count)
result_LA <- mutate(result_LA,normalized_emission = (count-min_LA)/(max_LA-min_LA))
result <- rbind(result_Baltimore,result_LA) #bind the two subsets
### activate the png device and mention the size
png("plot6.png",width = 480,height = 480)
###plot the histogram and give a title's name and x axis label is corrected
qplot(x=result$year,y=result$normalized_emission,col=as.factor(result$fips),geom=c("point","line"),xlab = "year",ylab = "Normalized Emission of PM2.5",main = "Changes in the PM2.5 of Motor Vehicle")       
### close the device to have a complete image.
dev.off()