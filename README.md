# Reaction Time attempt WMgrid

### Overview:

Old scripts that tried to utilize reaction time differences.

A function called getrtdiff.R allows one to get the reaction time difference of a trial preceding an error to that of a correct trial after an error. It in no way looks at the reaction time of the trial with an error, since the error cuts the trial short.

If there are 2 correct trials of the same level before an error in the same race the function averages these two for subtraction from the correct trial after an error. The amount of trials effected is outputted by the function, furthermore you can check logivec to filter for these trials. 

The outputted dataframe also shows the error level and the problem level (along with the actual error), reaction times (of the problem level) before and after along with the distance between these two reaction times. 

This script isn't eloquent yet gets the job done for WMgrid trials.

### Considerations:
+ Length of trial is unknown
+ Differing levels artificially effect RT's
+ Each kid has a variable amount of occurrences; this could adversely interplay with other factors. To strengthen analysis, it would be ideal of find a min amount of acceptable occurrences and randomly sample kids with more data.


### Data:

Password protected dropbox [**link**](https://www.dropbox.com/s/gcadz4if72re47u/WMgrid_trials_trainingfullpure.zip?dl=0) for data (only WMgrid)!

[**Example**](https://www.dropbox.com/s/tm1xai151701uad/example_getrtdiff.zip?dl=0) of the outputted dataframe from the function.

[**Dataframe**](https://www.dropbox.com/s/sz21h4k8cgqxo60/rt_values.zip?dl=0) with RT values of mean, median, SD and count. Used the script 'basic_rt_indi.R'.
