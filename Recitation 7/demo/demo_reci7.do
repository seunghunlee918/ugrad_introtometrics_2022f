/*====================================================================*/
* STATA demo for Recitation 7              
* Date: November 3rd, 2022
* Author: Seung-hun Lee                    
/*====================================================================*/

clear all 
set more off 

global reci7 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall 2022 - Intro to Econometrics/Recitation/Recitation 7/demo"
cd "$reci7"


/* To-do list
1. Three ways to run a panel regression
2. Outreg2 command
*/


* Install outreg2
ssc install outreg2, replace

***** 1. Three ways to run a panel regression
*** Open panel data
use "$reci7/deregulate.dta", replace

/** 
Regress the log of costs (vc) on the regulation dummy, year and 
the natural logs of three price variables and of stage
**/

*** You can run a fixed effects regression with a `reg' command
* dummy for airlines and years
tab airline, generate(d_airline)
tab year, generate(d_year)

** Log variables
local controls "vc pf pl pm stage"
foreach x in `controls'{
	gen log_`x'=log(`x')
}

* one way FEs
reg log_vc  d_airline* log_pl log_pm log_pf  log_stage reg,  vce(cluster airline)
reg log_vc  d_year* log_pl log_pm log_pf  log_stage reg,  vce(cluster airline)
*-> Question: reg gets dropped here, can you tell why?


* Twoway FE (I drop reg because this is multicollinear with year dummies)
reg log_vc  d_year* d_airline* log_pl log_pm log_pf log_stage ,  vce(cluster airline)


*** Another option is the `areg'
areg log_vc log_pl log_pm log_pf  log_stage reg, absorb(airline) vce(cluster airline)

* TWFE with areg
areg log_vc log_pl log_pm log_pf  log_stage i.year, absorb(airline) vce(cluster airline)

*** `xtreg' command
* Declare the data as a panel data using xtset
* Need to make airline a non-string variable
encode airline, generate(entity)
xtset entity year

xtreg log_vc log_pl log_pm log_pf  log_stage reg, fe vce(cluster airline)

* TWFE with xtreg
xtreg log_vc log_pl log_pm log_pf  log_stage i.year, fe vce(cluster airline)

***** 2. Outreg2
* Start a new table with the reg results
reg log_vc  d_airline* log_pl log_pm log_pf  log_stage reg,  vce(cluster airline)
outreg2 using "$reci7/results.doc", word replace keep(log_pl log_pm log_pf  log_stage reg) nocons ///
	ctitle(reg) bdec(3) tdec(2) rdec(2)  alpha(.01, .05, .10)

* add a new column with areg results
areg log_vc log_pl log_pm log_pf  log_stage reg, absorb(airline) vce(cluster airline)
outreg2 using "$reci7/results.doc", word append keep(log_pl log_pm log_pf  log_stage reg) nocons ///
	ctitle(areg) bdec(3) tdec(2) rdec(2)  alpha(.01, .05, .10)

* add a new column with reg results
xtreg log_vc log_pl log_pm log_pf  log_stage reg, fe vce(cluster airline)
outreg2 using "$reci7/results.doc",word append keep(log_pl log_pm log_pf  log_stage reg) nocons ///
	ctitle(xtreg) bdec(3) tdec(2) rdec(2)  alpha(.01, .05, .10)