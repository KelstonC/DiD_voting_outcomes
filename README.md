# Welcome

This is repository contains both all of the data work (done in jupyter notebook), the Stata code to run the difference-in-difference model, and 
final paper itself.

**This paper was written for my final project in Econ452 (An Econometrics course)**

The paper attempts to check whether there is a casual effect between the state of the economy and federal elections.
In doing so, two seperate difference-in-difference models are used, one to look at the probability of winning (binary outcome variable) and 
a continous variable which measures the change in the percentage of voters that voted for Democrats.
Thus, the two models record two interesting indicators: 
1. The `extensive` margin -- whether or not Democrats win
2. The `intensive` margin -- the marginal change in votes for Democrats

The policy in question was an Employment Securities Law that was updated in Nebraska, which ensured greater benefits for unemployed
workers.

The data used was: 
* County level data (demographics and economic indicators) for the states of Nebraska and Missouri -- `exogenous` variables (features)
* Voting outcomes at the Federal level in each county -- `endogenous` variables (target) 
  * Binary -- whether Democrats won in that county
  * 0 < Continous variable < 1 -- the percentage of the county population that voted for Democrats in that election cycle

Unfortunately, the model failed to assume parallel trends, in terms of voting behaviour, thus, a causal effect was rejected.

Please enjoy!
