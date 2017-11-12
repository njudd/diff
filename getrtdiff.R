#if you have a race with only one trial you get an error! Also if there are NA's in $Correct $prob string

getrtdiff <- function (wmgrid){
wmgrid$Phase.ID <- as.factor(wmgrid$Phase.ID) #making each race a factor
wmgrid$Problem.String <- as.character(wmgrid$Problem.String)
wmgrid$Problem.Level <- as.numeric(as.character(wmgrid$Problem.Level))
#empty vec for dataframe
rt1 <- vector()
rt2 <- vector()
Account <- vector()
Prob_str <- vector()
Answers <- vector()
error_lev <- vector()
prob_lev <- vector()
Problem.Type <- vector()
logivec <- vector()
diff <- vector()
Distance <- vector()
#counters
c <- 1
amountoflastif <- 0 #changed 1 to 0 to make counter correct
  for (i in 1:length(levels(wmgrid$Phase.ID))){
    id <- levels(wmgrid$Phase.ID)[i] 
    phasevec <- wmgrid[wmgrid$Phase.ID==id,]
    if (length(phasevec$Correct)>1){            #fucks up my function #make this condition to catch races with only one exercise
      for (q in 1:(length(phasevec$Correct)-1)){ #because of this line you can never tell if the last error in a race is incorrect; yet needed for diff
        #print(phasevec)
        if (phasevec$Correct[q]==FALSE && phasevec$Correct[q+1]==TRUE){
          lev <- phasevec$Problem.Level[q+1] #this line is not needed
            if (sum(phasevec$Correct[1:q])==0){
            }else{
              for (e in seq(q,1,-1)){
                if(phasevec$Problem.Level[e]==lev && phasevec$Correct[e]==1){
                  rt2[c] <- phasevec$Response.Time[e]
                  Account[c] <- as.character(phasevec$Account[q])
                  Prob_str[c] <- as.character(phasevec$Problem.String[q])
                  Answers[c] <- as.character(phasevec$Answers[q])
                  Distance[c] <- q - e
                  rt1[c] <- phasevec$Response.Time[q+1]
                  error_lev[c] <- phasevec$Problem.Level[q]
                  prob_lev[c] <- phasevec$Problem.Level[q+1] #this was q-1
                  Problem.Type[c] <- as.character(phasevec$Problem.Type[q])
                  logivec[c] <- 0
                  if(e-1!=0){
                    if(phasevec$Problem.Level[e]==phasevec$Problem.Level[e-1] && phasevec$Correct[e-1]==1){    #error missing value where TRUE/FALSE needed
                      rt2[c] <- (phasevec$Response.Time[e] + phasevec$Response.Time[e-1])/2 
                      amountoflastif <- amountoflastif + 1
                      logivec[c] <- 1
                    }
                  }
                  diff[c] <- rt1[c] - rt2[c]
                  c <- c+1
                  break
                }else{
            }
          }
        }
        }else{
      }
    }
    }else{
  } 
  }
print(amountoflastif)
df <- data.frame(Account,Prob_str,Answers,error_lev,prob_lev,rt1,rt2,Problem.Type,diff,logivec,Distance)
return(df)
}


#everyvector need to build up and then you can make a df