setwd("~/Dropbox/KI/Diff_project/Grid_diff")
x <- read.csv("WMgrid_training_full_pure.csv")
keep <-x

library('tidyverse')

x <- x %>% 
  filter(Correct==1) %>% 
  group_by(Account,Problem.Level) %>% 
  summarise(mean = mean(Response.Time), median = median(Response.Time), sd = sd(Response.Time), count = n())

write_csv(x, "rt_values.csv")
