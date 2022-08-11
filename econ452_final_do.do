import excel "/Users/kelstonchen/Documents/Queens_2021_2022/ECON_452/county_level/Econ452_final_dataset.xlsx", sheet("Sheet1") firstrow clear

// Generate our DiD variable, post policy time period for our treatment group (Nebraska)
gen post_policy_treatment = policy * time_dummy
gen lnWeekly_wage = log(week_wage)

gen CountyS = state + county

// Encoding and setting up to cluster for County
// encode state, gen(State)
encode CountyS, gen(County)
xtset County

// Clustering DiD
// Only economic variables
reg dems_won i.policy i.time_dummy i.post_policy_treatment vacancy_rate poverty_rate lnWeekly_wage no_est, cluster(County)
outreg2	using econ452_table1.xls, replace ctitle(Extensive Margin Model (1)) addtext(Clustered SE, YES)
estimates store Ext_econ
reg voted_dem i.policy i.time_dummy i.post_policy_treatment vacancy_rate poverty_rate lnWeekly_wage no_est, cluster(County)
outreg2 using econ452_table1.xls, append ctitle(Intensive Margin Model (2)) addtext(Clustered SE, YES)
estimates store Int_econ
// reg incumbency_votes i.policy i.time_dummy i.post_policy_treatment incumbency vacancy_rate poverty_rate lnWeekly_wage no_est, cluster(County)

// With demographic variables
reg dems_won i.policy i.time_dummy i.post_policy_treatment vacancy_rate lnWeekly_wage no_est poverty_rate non_white Total_pop Median_age, cluster(County)
outreg2	using econ452_table1.xls, append ctitle(Extensive Margin Model (1)) addtext(Clustered SE, YES)
estimates store Ext_all
reg voted_dem i.policy i.time_dummy i.post_policy_treatment vacancy_rate lnWeekly_wage no_est poverty_rate non_white Total_pop Median_age, cluster(County)
outreg2	using econ452_table1.xls, append ctitle(Intensive Margin Model (2)) addtext(Clustered SE, YES)
estimates store Int_all
// reg incumbency_votes i.policy i.time_dummy i.post_policy_treatment incumbency vacancy_rate lnWeekly_wage no_est poverty_rate non_white Total_pop Median_age, cluster(County)

// Creating a table
estimates table Ext_econ Ext_all Int_econ Int_all, star (0.1 .05 .01) stats(N r2 r2_a)

// Falsification Test with Placebo Treatment
drop if year >= 2012

gen placebo_time = (year >= 2004)
gen post_placebo_treatment = placebo_time * policy

reg dems_won i.policy i.placebo i.post_placebo_treatment vacancy_rate lnWeekly_wage no_est poverty_rate non_white Total_pop Median_age, cluster(County)
outreg2	using econ452_table2.xls, replace ctitle(Placebo Policy, Extensive Model) addtext(Clustered SE, YES)
reg voted_dem i.policy i.placebo i.post_placebo_treatment vacancy_rate lnWeekly_wage no_est poverty_rate non_white Total_pop Median_age, cluster(County)
outreg2	using econ452_table2.xls, append ctitle(Placebo Policy, Intensive Model) addtext(Clustered SE, YES)

// Cannot assume parallel trends; looking into the data...
import excel "/Users/kelstonchen/Documents/Queens_2021_2022/ECON_452/county_level/Econ452_final_dataset.xlsx", sheet("Sheet1") firstrow clear

// Tabbing to look at how win rates were trending before an after treatment
tab dems_won if state == "NEBRASKA" & year < 2008
tab dems_won if state == "NEBRASKA" & year >= 2008 & year < 2012 // OBAMA EFFECT

tab dems_won if state == "MISSOURI" & year < 2008
tab dems_won if state == "MISSOURI" & year >= 2008 & year < 2012
