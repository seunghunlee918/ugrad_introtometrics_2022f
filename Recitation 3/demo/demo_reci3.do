/*====================================================================*/
* STATA demo for Recitation 2              
* Date: September 16th, 2022
* Author: Seung-hun Lee                    
/*====================================================================*/

clear all 
set more off 

global reci3 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall 2022 - Intro to Econometrics/Recitation/Recitation 3/demo"
cd "$reci3"


/* To-do list
1. Normal and robust standard errors
2. Customizing hypothesis tests: confidence intervals and tests for specific values
*/


***** 1. Difference between normal adnd robust estimtors
* For this exercise, we will split the dataset into two: One dataset for foreign cars, the other for domestic
sysuse auto



* Regressing on the dataset
/*
Question: Are longer cars more expensive?
So you want to regress
price_i = cons + beta*length_i + u_i
*/
regress price length
regress price length, vce(robust)
* also works:
regress price length, robust
*--> Note: It is possible that robust errors can reduce standard errors, but does not happen that often


regress price weight
regress price weight, vce(robust)


***** 2. Customizing the tests
* Default null: coefficient =0 at %5 significance level
regress price length

* what about 99% confidence interval
regress price length, level(99)

* You want to test if coefficient on  length is equal to 50?
test length=50



************ Interesting combinations (for multivariate regression)
regress price length weight

* Want to test if the coefficients on length and weight equals -90
test length + weight = -90

* Want to test the variables separately (whether each of them are 0 or not)
test length weight
