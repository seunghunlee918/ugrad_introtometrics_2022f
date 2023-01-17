/*====================================================================*/
* STATA demo for Recitation 2              
* Date: September 16th, 2022
* Author: Seung-hun Lee                    
/*====================================================================*/

clear all 
set more off 

global reci2 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall 2022 - Intro to Econometrics/Recitation/Recitation 2/demo"
cd "$reci2"


/* To-do list
1. Keep/drop observations
2. Combining different datasets 
3. Regress command
*/


***** 1. Keep and drop observations
* For this exercise, we will split the dataset into two: One dataset for foreign cars, the other for domestic
sysuse auto


* keep only foreign cars
keep if foreign==1

* Save newly generate dataset
save "$reci2/auto_foreign.dta", replace


* Reopen dataset and keep domestic ones
clear /*not clear all, since this would deactivate the global macro we set up*/

sysuse auto

* domestic cars only, we achieve this by droppping foreign cars
drop if foreign==1

save "$reci2/auto_domestic.dta", replace


***** 2. Combining datasets using append
* We have domestic cars only, so we append the foreign car data here

append using "$reci2/auto_foreign.dta"
*--> Notice the change in observations
*--> If the two dataset that you are appending have variable names that don't match, it will create a new one


* extension: instead of keeping or dropping observations, you can do this to variables
* We keep everything but displacement
keep make price mpg rep78 headroom trunk weight length turn gear_ratio foreign

* we drop gear_ratio
drop gear_ratio


* Regressing on the dataset
/*
Question: Are longer cars more expensive?
So you want to regress
price_i = cons + beta*length_i + u_i
*/
regress price length

/*
Question: Are foreign cars more expensive?
Foreign is a dummy variable, but not too much different in terms of coding
price_i = cons + beta*foreign_i + u_i
*/
regress price foreign


/*
Multivariable regression: Just list more variables!
*/
regress price length foreign

