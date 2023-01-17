/*====================================================================*/
* STATA demo for Recitation 2              
* Date: September 16th, 2022
* Author: Seung-hun Lee                    
/*====================================================================*/

clear all 
set more off 

global reci4 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall 2022 - Intro to Econometrics/Recitation/Recitation 4/demo"
cd "$reci4"


/* To-do list
1. Multivariate regression tables: Multicollinarity tricks
2. Understanding thables, F-test, and hypothesis test
3. Loops!
*/


***** 1. Multicollinearity (and local macro)
* For this exercise, we will split the dataset into two: One dataset for foreign cars, the other for domestic
sysuse auto

* double length= length X2 (for multicollinearty purpose)
generate doublelength = length*2

* domestic variable (dummy variable trap)
generate domestic = 1 if foreign ==0 
replace domestic = 0 if foreign ==1 


* Local macro: temporary list of things that are only active in one stata run (not repeated)
local control "length weight"
local longcontrol "length weight foreign"

* Perfect collinarity due to creation of a multiple of an existing variable
regress price `control', robust
regress price `control' doublelength , robust
regress price doublelength `control'  , robust

* dummy variable trap
regress price `longcontrol', robust
regress price `longcontrol' domestic, robust


**** 2. Tables, F-test, hypothesis test
regress price length weight foreign, robust

* (Adjusted) R^2
display e(r2)
display e(r2_a)

* Test whether each coefficient is 0 (so 3 variable test)
test length weight foreign
test length weight

* Test for a particular value
test weight = 5

* Test for linear combination of coefficients
test length + weight = 80


***** 3. Loops!
/*
Very useful if you are doing repetitive tricks
*/

local loopcontrol "length weight mpg foreign displacement"

foreach x in `loopcontrol'{
	reg price `x', robust
}


* Or 
forvalues i=1/5{
	local a: word `i' of `loopcontrol'
	gen var`i'=`a'
	order var`i', after(`a')
}
