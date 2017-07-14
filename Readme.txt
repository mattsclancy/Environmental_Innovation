The following a short guide to the Matlab simulations in:

################################################################################

Clancy, Matthew, and GianCarlo Moschini. Forthcoming. Mandates and the Incentive 
for Environmental Innovation. American Journal of Agricultural Economics.

Clancy, Matthew, and GianCarlo Moschini. 2016. Pushing and Pulling Environmental
Innovation: R&D Subsidies and Carbon Taxes. Prepared for the AAEA annual 
meeting: http://ageconsearch.umn.edu/record/235710

################################################################################

These simulations are performed by the program Parameter_Loop, which generates a
table of simulation results. Each row of the table is a different parameter and
policy combination. The choices of parameter values are described in the papers.
Note that this code considers 3 policy instruments: carbon tax, mandate, and R&D
subsidy. The code takes several days to run at its default setting.

What follows is a short description of what each program does. These programs are
nested, and under each program or function, I list in bullet points the other 
functions that are inputs.

## Top level ###################################################################

Parameter_Loop: Creates a table of simulation outcomes for every parameter
and policy combination.
-m1_outcomes
-golden_section_search
-niw

## Nested one level ############################################################

m1_outcomes: Creates a table of simulation outcomes for a given parameter and
policy combination
-mp
-m1_nw
_m1_nw_1
-m1_p_triple
-m1_expost_outcomes

golden_section_search: Finds the welfare maximizing policy over an interval.
-constr_Qm
-m1_policy_outcomes

niw: Computes welfare for a given parameter and policy combination, absent
innovation.
-Q_eq

## Nested two levels ###########################################################

mp: Divides an interval into n sections and returns the midpoint of each as well
as the length of each interval.

m1_nw: Computes the expected number of innovators for each omega in a set, given
a policy and parameter combination.
-m1_Epr

m1_nw_1: Computes the expected number of innovators (0 or 1) for each omega in a
set, given a policy and parameter combination.
-m1_Epr

m1_p_triple: For a set of omegas, and a matching set of the number of innovators 
at each omega, generates a list of discrete possible realizations of theta1 and 
theta2, and computes the probability of every omega, theta1, theta2 combination.

m1_expost_outcomes: Computes outcomes for a given set of parameters, policies, 
omega, theta1, theta2, and number of innovators.
-m1_hiQ_eq
-m1_hiconQ_eq
-Q_eq (see Nested two levels)

constr_Qm: Computes the maximum feasible mandate; the one at which, demand for 
renewable energy at the price imposed by the mandate is just satisfied by the
mandate

m1_policy_outcomes: Identical to m1_outcomes but with a simplified way of 
keeping the same parameters and changing the policy under consideration.
-m1_outcomes (see Nested one level)

Q_eq: Gives the quantity of renewable energy under which supply and demand for 
energy are equilibrated under a mandate.

## Nested three levels #########################################################

m1_Epr: Computes the expected profit for a firm considering entry when there are
n entrants and a given omega and parameter and policy regime.
-m1_pr

m1_hiQ_eq: Gives the quantity of renewable energy under which supply and demand
for energy are equilibrated without a mandate and without a binding constraint
from the second-best innovation.

m1_hiconQ_eq: Gives the quantity of renewable energy under which supply and 
demand for energy are equilibrated without a mandate and with a binding 
constraint from the second-best innovation.

## Nested four levels ##########################################################

m1_pr: For a particular realization of theta 1 and theta2, and other parameters,
computes the expost profit of the winning innovator.
-m1_hiQ_eq (see Nested three levels)
-m1_hiconQ_eq (see Nested three levels)

################################################################################
