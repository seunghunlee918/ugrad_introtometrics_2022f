/*====================================================================*/
* STATA demo for Recitation 1              
* Date: September 8th, 2022
* Author: Seung-hun Lee                    
/*====================================================================*/


/* To-do list
1. Commenting on the codes
2. How best to start your codes
3. Setting up directories
4. Playing around with variables in the data.
*/


***** 1. `Note-taking' (or commenting) on STATA
/* Not everything on the code file has to be a STATA command. In fact,
I recommend commenting on the codes extensively to make sure that 
you are knowledgeable about what the codes are intended to do. 
The comments are in green. codes in other colors are commands that the 
STATA executes.														*/

* You can comment on one line using `*' (as I did for this line)


/* If you have multiple lines of codes or you want to begin commenting
from the middle of the line, you can wrap them around
`/*' and `*/', as I did for this set of comments
*/


***** 2. Starting the codes + 3. directories

clear all /*clears the memory of any previous coding work*/
set more off /*Prevents STATA from pausing when the results window is filled up*/

/* Directories: By default STATA directory is set to whereever you installed it
If you want to change them, do as follows
*/

* Global macros: Defines names for filepahts, variable lists, active throughtout the session until `clear all'
* For temporary ones, we can use local macro (to be covered later)
* using `cd' command (change directories): cd "your own filepath": Useful for storing your outputs

global reci1 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall 2022 - Intro to Econometrics/Recitation/Recitation 1/demo"
cd "$reci1"


sysuse auto /* Opens a toy Stata dta file for practice*/
*use "filepath/data.dta", replace

***** 4. Playing around with the data
** Logs
/*Logs can store your codes and outputs in a displaybale form. 
When you submit your problem set with codes, we recommend using logs.
It is perfectly fine to have pdf version of your do file instead, if this is tricky. 
Make sure to close them at the end of the code. (Otherwise, the stata may not run) */

log using "$reci1/log_demo.smcl", replace

** Summary statistics
summarize /*show summary stats for all variables*/
summarize price /*for just one variable*/
summarize price if weight>2000  /*only for cars weighing above 2000*/
summarize price if foreign==1 /*only for foreign cars*/

summarize price if foreign==1 & weight>2000
summarize price if foreign==1 | weight>2000
 
sort foreign
by foreign: summarize price /*summarize separately by foreign/domestic categories*/

* Tabulate: A command that spits out frequency tables
tabulate foreign /* oneway frequency table for domestic vs foreign*/
tabulate trunk foreign /* twoway frequency table for domestic vs foreign and various trunk sizes*/

tabulate trunk foreign, row /*percentage for each row variable*/
tabulate trunk foreign, column /*percentage for each column variable*/

* Simple t-test for means
/* 
Say you want to compare the price between foreign and domestic cars and confirm that 
foreign cars are more expensive
*/
ttest price, by(foreign)
ttest price if length>180, by(foreign) /*only for large cars*/

* Graphs
histogram length /*make histogram using headroom */
graph export "$reci1/histogram_length.png", replace /*you can use other extensions like .jpg or .gph */

* graphs with two variables
/*
Useful for summarizing relationship between the two variables visually
Say that you want correlation between price and length of cars 
(i.e. longer cars are more expensive)
*/
twoway scatter price length /*price in y, length in x */
graph export "$reci1/scatterplot.png", replace

* fancier graphs with a line and scatter plot
twoway (scatter price length) (lfit price length)
graph export "$reci1/scatterlineplot.png", replace

* ends logs (you need this before you move on to other Stata project!)
log close

* Since default log format is smcl, we need to change to pdf format for submission
translate "$reci1/log_demo.smcl" "$reci1/log_demo.pdf", replace
