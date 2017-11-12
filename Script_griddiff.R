setwd("~/Dropbox/KI/Diff_project/Grid_diff")
x <- read.csv("WMgrid_training_full_pure.csv")
setwd("~/Dropbox/KI")
library("dplyr")
source("getrtdiff.R")
#before this check that you have a max of 30 days
x <- x[!is.na(x$Correct),]
keep1 <- x

x <- getrtdiff(x)
keep2 <- x

#x <- x[x$logivec==1,] #only those with two occurances


x <- x %>%
  group_by(Account) %>% 
  summarise(diff = median(diff))

x <- as.data.frame(x)

#x$prob_lev = as.factor(x$prob_lev)
#x <- x[x$prob_lev==3 | x$prob_lev==4 | x$prob_lev==5 | x$prob_lev==6 ,] #tried only lv 4&5 also tried only lv4, all on data logivec==1


#x <- x %>%
  #group_by(prob_lev) %>% 
  #summarise(mean = mean(diff), upperCI = Rmisc::CI(diff)[1], lowerCI = Rmisc::CI(diff)[3])


grit <- read.csv("gritscores.csv")
x <- merge(x,grit, by = "Account")


cicle_lm <- lm(diff ~ Grit_sum, x)
summary(cicle_lm)


hist(x$Distance)
x <- x[x$Distance==1,]

testF<- lm(WM_Component_post  ~ Grit_sum + WM_Component_bas, df_controlchecks)
summary(testF)
testF<- lm(WM_Component_post  ~ diff + WM_Component_bas, df_controlchecks)
summary(testF)


### trying to see how many mistake strings over 2 on a planet

instancesofovertwo <- table(x$Account)
instancesofovertwo <- as.data.frame(instancesofovertwo)
names(instancesofovertwo)[1] <- "Account"
instancesofovertwo <- merge(instancesofovertwo,grit,by = "Account")


repeatstrings_grid_lm <- lm(Freq ~ Grit_sum, instancesofovertwo)
summary(cicle_lm)

## this doesn't take the same amount of grid trails//want first 300 trails per account to get the amount of mistakes
onlyaccountswithover300 <- keep1[keep1$Account %in% ct$Var1,]
onlyaccountswithover300 <- droplevels(onlyaccountswithover300)
levels(onlyaccountswithover300$Account)

testF = split(onlyaccountswithover300, onlyaccountswithover300$Account)
ouputF = lapply(testF,'[',1:300,)
rtlist = lapply(ouputF, getrtdiff)

persistnum = lapply(lapply(lapply(lapply(rtlist,'[[',11),as.character),as.numeric),mean)

persistnum = as.data.frame(persistnum)
persistnum <- data.frame(r1=names(persistnum), t(persistnum))
names(persistnum)[1] = "Account"
names(persistnum)[2] = "errors"

persistnum <- merge(persistnum,grit,by="Account")

mistake_length_lm <- lm(errors ~ Grit_sum, persistnum)
summary(mistake_length_lm)


