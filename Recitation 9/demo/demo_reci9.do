/*====================================================================*/
* STATA demo for Recitation 9              
* Date: November 17th, 2022
* Author: Seung-hun Lee                    
/*====================================================================*/

clear all 
set more off 

global reci9 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall 2022 - Intro to Econometrics/Recitation/Recitation 9/demo"
cd "$reci9"


/* To-do list
1. IV regression, estimation and postestimation
*/

** Data: Acemoglu, Johnson, Robinson 2001
/*
Question: Does institutions explain growth?
Regress:
log(GDP) = b0 + b1risk + b2lat + b3Asia + b4Africa + b5Other+ e

Risk (legal protection against expropriation) is endogenous, so instrument with log(mortality) of European settlers to Latam
*/

***** 1. OLS: just to warm things up 
import excel "${reci9}/AJR2001.xlsx", sheet("Sheet1") firstrow clear

reg loggdp risk lat asia africa other

***** 2. IV regression: Wrong and  right way
*wrong
reg risk logmort0 lat asia africa other
predict  riskhat, xb
reg loggdp riskhat lat asia africa other

*right
ivregress 2sls loggdp (risk=logmort0) lat asia africa other

* Get first stage straight away
ivregress 2sls loggdp (risk=logmort0) lat asia africa other, first 

***** 3. Post regression: Wrong and  right way
ivregress 2sls loggdp (risk=logmort0 logmortnaval2)  lat asia africa other, first 

estat firststage
estat overid

* Alternatively, 
predict e, resid

reg e logmort0 logmortnaval2 lat asia africa other
test logmort0 logmortnaval2 /*Then multiply with the number of instrumental variables*/
