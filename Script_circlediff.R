#must first make the clean data using data_clean_wmgrid.R
#nothing works to make it sig

setwd("~/Dropbox/KI/Diff_project/Circle_diff")
x <- read.csv("WMcircle_training_full_pure.csv")
setwd("~/Dropbox/KI")
source("getrtdiff.R")
keep1 <- x

#before this check that you have a max of 30 days
x <- x[!is.na(x$Correct),]
x <- getrtdiff(x)


keep2 <- x

x <- x[x$logivec==1,] #only those with two occurances


x <- x %>%
  group_by(Account, prob_lev) %>% 
  summarise(diff = median(diff))

x <- as.data.frame(x)

x$prob_lev = as.factor(x$prob_lev)
x <- x[x$prob_lev==3 | x$prob_lev==4 | x$prob_lev==5 | x$prob_lev==6 ,] #tried only lv 4&5 also tried only lv4, all on data logivec==1


x <- x %>%
  group_by(Account) %>% 
  summarise(diff = mean(diff))

x <- as.data.frame(x)

x <- merge(x,grit, by = "Account")


cicle_lm <- lm(diff ~ Grit_sum, x)
summary(cicle_lm)
