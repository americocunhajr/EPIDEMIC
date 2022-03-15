# EPIDEMIC - Epidemiology Educational Code

The EPIDEMIC is an easy-to-run educational Matlab toolkit for epidemiological analysis, which offers functionalities for modeling an epidemic, monitoring its progress and forecasting the underling numbers of interest. This code is, first of all, an educational tool for researchers and students who are interested in computational epidemiology. The programs and tutorials are designed to offer good introductory material for beginners in the field. But they can also be used to analyze epidemic data, as well as in the construction of some simplistic epidemic models. 

## 🔧 Functions of module Modeling

### Function rhs_SIR:

This function defines the system of ODEs for the SIR epidemic model.

The dynamic state coordinates are:
  
  S = susceptibles        (number of individuals)
  
  I = infected            (number of individuals)
 
  R = recovered           (number of individuals)
  
  C = cumulative infected (number of individuals)

The epidemic model parameters are:

 N  = population size   (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 gamma = recovery rate     (days^-1)

Inputs:

 t: time                    - double
 
 y: state vector            - double array (4x1)
 
 param: parameters vector   - double array (3x1)
 
Output:

dydt: state rate of change - double array (4x1)

### Função 02:
- Descrição Da Função
