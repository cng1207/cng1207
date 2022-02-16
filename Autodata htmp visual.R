#Analysis and visualization of "Auto" data. 
# info can be found https://rdrr.io/cran/ISLR/man/Auto.html
library(Hmisc)
library(ggplot2)
library(reshape2)
#read the data
Auto <-read.csv("Auto.csv", header=TRUE)
#find the mean/sd of weight
summarize(Auto, mean(weight),sd(weight))
#dind the mean/sd of mpg given it is one of the three cars
Auto %>%
  filter(Auto$name %in% c("ford pinto", "amc matador", "ford maverick")) %>%
  summarize(Meanmpg = mean(mpg),
            SDmpg = sd(mpg)
  )
#find car with greatest acceleration
Auto %>%
       group_by(name) %>%
       summarize(avgacc = mean(acceleration)
                  +                )%>%
       arrange(-avgacc)
#creates a hmp and hmpclean df which excludes qualitative variable and NA
hmp = subset(hmp, select = -c(name) )
hmpclean <- na.omit(hmp)
#creates a histogram for all columns for visualizing data spread
hist.data.frame(hmpclean)
#creates a htmp df for cleaining and melting data to create a cor heatmap
htmp <- as.data.frame(cor(hmpclean[1:ncol(hmpclean)]))
htmp.m <- data.frame(row=rownames(htmp),htmp)
htmp.m <- melt(htmp.m)
#sorts data for better visualization
htmp.m$row <- factor(htmp.m$row, levels=rev(unique(as.character(htmp.m$variable))))
#creates visualization of heatmap
ggplot(htmp.m, aes(row, variable)) +
                    geom_tile(aes(fill=value)) +
          scale_fill_gradient2()
