
# Libraries and data ---------------------------------------------------------------
library(ggplot2)
library(magrittr)
library(tidyverse)
library('corrplot')

data <- read.csv('D:/kuda_kak/kuda_kak_01.csv', sep='\t')


# Regression --------------------------------------------------------------

df1 <- data
fit <- glm(Comp ~ Sub +
             SubAnimacy + DO + sem_humq + sem_abstract + 
             sem_freq + sem_physq + sem_size + sem_quant + sem_dist + 
             sem_speed,
           data = df1, family = binomial()) 
summary(fit)


# Correlation -------------------------------------------------------------


loaddata <- data
df = subset(loaddata, select = -c(13,14) )
corrmatr <- cor(df)
res1 <- cor.mtest(df, conf.level = .99)
corrplot(corrmatr, p.mat = res1$p, insig = "blank")


# T-test ------------------------------------------------------------------

length(data$Sub[data$Sub==1])
t.test(data$Sub[data$Comp==0], data$Sub[data$Comp==1])
# 109
# t = -2.2569, df = 124.8, p-value = 0.02575

length(data$Sub[data$SubAnimacy==1])
t.test(data$SubAnimacy[data$Comp==0], data$SubAnimacy[data$Comp==1])
# 33
# t = -0.72329, df = 138.22, p-value = 0.4707

length(data$Sub[data$DO==1])
t.test(data$DO[data$Comp==0], data$DO[data$Comp==1])
# 41
# t = -1.3085, df = 144.89, p-value = 0.1928

length(data$Sub[data$sem_humq==1])
t.test(data$sem_humq[data$Comp==0], data$sem_humq[data$Comp==1])
# 39
# t = -1.9433, df = 157.36, p-value = 0.05377


length(data$Sub[data$sem_abstract==1])
t.test(data$sem_abstract[data$Comp==0], data$sem_abstract[data$Comp==1])
# 97
# t = 1.0457, df = 125.96, p-value = 0.2977

length(data$Sub[data$sem_freq==1])
t.test(data$sem_freq[data$Comp==0], data$sem_freq[data$Comp==1])
# 3

length(data$Sub[data$sem_physq==1])
t.test(data$sem_physq[data$Comp==0], data$sem_physq[data$Comp==1])
# 16
# t = 0.42728, df = 115.4, p-value = 0.67

length(data$Sub[data$sem_size==1])
t.test(data$sem_size[data$Comp==0], data$sem_size[data$Comp==1])
# 19
# t = -2.6521, df = 196.65, p-value = 0.008653

length(data$Sub[data$sem_quant==1])
t.test(data$sem_quant[data$Comp==0], data$sem_quant[data$Comp==1])
# 8

length(data$Sub[data$sem_dist==1])
t.test(data$sem_dist[data$Comp==0], data$sem_dist[data$Comp==1])
# 9

length(data$Sub[data$sem_speed==1])
t.test(data$sem_speed[data$Comp==0], data$sem_speed[data$Comp==1])
#3


# +_ significant ----------------------------------------------------------

ggplot(data, aes(x = Sub, fill = Comp, group = Comp))+
  geom_bar(stat = "count",position=position_dodge())
ggplot(data, aes(x = sem_humq, fill = Comp, group = Comp))+
  geom_bar(stat = "count",position=position_dodge())
ggplot(data, aes(x = sem_size, fill = Comp, group = Comp))+
  geom_bar(stat = "count",position=position_dodge())


# Random Forest -----------------------------------------------------------

library(party)
library(randomForest)

output.forest <- randomForest(Comp ~ Sub +
                                SubAnimacy + DO + sem_humq + sem_abstract + 
                                sem_freq + sem_physq + sem_size + sem_quant + sem_dist + 
                                sem_speed, 
                              data = data, importance = TRUE)

print(output.forest) 

importance(output.forest)
varImpPlot(output.forest, type=2) #plot MeanDecreaseGini
