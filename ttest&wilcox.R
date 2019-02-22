#t-test
data <- read.csv("Info_wide.csv", header=TRUE)
shapiro.test(data$Ainfo)
shapiro.test(data$Binfo)
t.test(data$Ainfo, data$Binfo, var.equal = FALSE)

#plot
library(ggplot2)
grdata<-read.csv("Info_gr.csv", header=TRUE)
ggplot(data=grdata, aes(x=Group, y=Info, fill=Group)) +
  geom_bar(stat="identity") + ggtitle("Blah"))

#Mann Whitney U aka Wilcoxon Rank-Sum Test
help("wilcox.test")
grdata$Numeric <- ifelse(grdata$Group=="A", 1, 0)
wilcox.test(grdata$Numeric, grdata$Info, 
            alternative = "two.sided", paired=FALSE, conf.level=0.95)
wilcox.test(grdata$Info ~ grdata$Numeric, paired=F)
wilcox.test(grdata$Info, grdata$Numeric, paired=F)