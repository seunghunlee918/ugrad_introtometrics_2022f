***********************
* Demo files for Problem set 6
* Seung-hun Lee
* No permission needed in using/reproducing/sharing this do file
***********************

*************** Things I put on the beginning of each code

clear all 
set more off 

cd "/Volumes/GoogleDrive/내 드라이브/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation8"

global reci8 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation8"



* Open a dta file
use "$reci8/smoking.dta", replace


* Q1
* a
summarize smoker
summarize smoker if smkban==1
summarize smoker if smkban==0

*b 
reg smoker smkban, vce(robust)

*c-e
gen agesq = (age)^2
reg smoker smkban female age agesq hsdrop hsgrad colsome colgrad black hispanic, vce(robust)
test hsdrop hsgrad colsome colgrad

* Filling out the table
logit smoker smkban female age agesq hsdrop hsgrad colsome colgrad black hispanic, vce(robust)
* Mr.A
margins, at(smkban = 1 female=0 age=20 agesq=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0)
margins, at(smkban = 0 female=0 age=20 agesq=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0)
* Ms.B
margins, at(smkban = 1 female=1 age=40 agesq=1600 hsdrop=0 hsgrad=0 colsome=0 colgrad=1 black=1 hispanic=0)
margins, at(smkban = 0 female=1 age=40 agesq=1600 hsdrop=0 hsgrad=0 colsome=0 colgrad=1 black=1 hispanic=0)

probit smoker smkban female age agesq hsdrop hsgrad colsome colgrad black hispanic, vce(robust)
* Mr.A
margins, at(smkban = 1 female=0 age=20 agesq=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0)
margins, at(smkban = 0 female=0 age=20 agesq=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0)
* Ms.B
margins, at(smkban = 1 female=1 age=40 agesq=1600 hsdrop=0 hsgrad=0 colsome=0 colgrad=1 black=1 hispanic=0)
margins, at(smkban = 0 female=1 age=40 agesq=1600 hsdrop=0 hsgrad=0 colsome=0 colgrad=1 black=1 hispanic=0)


reg smoker smkban female age agesq hsdrop hsgrad colsome colgrad black hispanic, vce(robust)
* Mr.A
margins, at(smkban = 1 female=0 age=20 agesq=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0)
margins, at(smkban = 0 female=0 age=20 agesq=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0)
* Ms.B
margins, at(smkban = 1 female=1 age=40 agesq=1600 hsdrop=0 hsgrad=0 colsome=0 colgrad=1 black=1 hispanic=0)
margins, at(smkban = 0 female=1 age=40 agesq=1600 hsdrop=0 hsgrad=0 colsome=0 colgrad=1 black=1 hispanic=0)