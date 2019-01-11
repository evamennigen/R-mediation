# mediation analysis
install.packages("mediation")
library(mediation)

# other helpful packages
install.packages("openxlsx")
library(openxlsx)
install.packages("ggplot2")
library(ggplot2)
install.packages("tidyverse")
library(tidyverse)


# if excel file is created in matlab, open and close it in excel before trying to import it to R; file should have all the variables you want to use
df <- read.xlsx("/Users/$YOURPATH/data.xlsx", colNames = TRUE)

### using Generalized Linear Models

# first fit the mediator model: the mediator is modeled as a function of 'treatment' and covariates
linear_model.Mediator.fit <- lm(Mediator ~ treatment + Cov1 + Cov2 + CovN, data = df)

# then model the outcome variable as a function of the mediator, 'treatment', and the same set of covariates as in the mediator model; linear regression fit with least squares and probit regression
linear_model.OutVar.fit <- glm(OutVar ~ Mediator + treatment + Cov1 + Cov2 + CovN, data = df) # you can also enter an interaction term (Mediator * treatment)

# mediate function uses both model fits as inputs; 
# specify 'treatment' ("treat") and mediator; 
# simulation type Quasi-Bayesian Monte Carlo or bootstrapping

# using bootstrap
Mediation.model <- mediate(linear_model.Mediator.fit, linear_model.OutVar.fit, boot = TRUE, treat = "treatment", mediator = "Mediator", sims = 1000)

# summary of results
summary(Mediation.model)

