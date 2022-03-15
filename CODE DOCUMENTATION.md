# EPIDEMIC - Epidemiology Educational Code

The EPIDEMIC is an easy-to-run educational Matlab toolkit for epidemiological analysis, which offers functionalities for modeling an epidemic, monitoring its progress and forecasting the underling numbers of interest. This code is, first of all, an educational tool for researchers and students who are interested in computational epidemiology. The programs and tutorials are designed to offer good introductory material for beginners in the field. But they can also be used to analyze epidemic data, as well as in the construction of some simplistic epidemic models. 

## 🔧 Functions of module Modeling

### rhs_SIR:

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

### rhs_SEIR:

This function defines the system of ODEs for the SEIR epidemic model.

The dynamic state coordinates are:
  
  S = susceptibles        (number of individuals)
  
  E = exposed             (number of individuals)
  
  I = infected            (number of individuals)
 
  R = recovered           (number of individuals)
  
  C = cumulative infected (number of individuals)

The epidemic model parameters are:

 N  = population size   (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 alpha = latent rate       (days^-1)
 
 gamma = recovery rate     (days^-1)

Inputs:

 t: time                    - double
 
 y: state vector            - double array (5x1)
 
 param: parameters vector   - double array (4x1)
 
Output:

dydt: state rate of change - double array (5x1)

### rhs_SEIRD:

This function defines the system of ODEs for the SEIRD epidemic model.

The dynamic state coordinates are:
  
  S = susceptibles        (number of individuals)
  
  E = exposed             (number of individuals)
  
  I = infected            (number of individuals)
 
  R = recovered           (number of individuals)
  
  D = deceased            (number of individuals)
  
  C = cumulative infected (number of individuals)

The epidemic model parameters are:

 N0    = initial population size (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 alpha = latent rate       (days^-1)
 
 gamma = recovery rate     (days^-1)
 
 delta = death rate              (days^-1)

Inputs:

 t: time                    - double
 
 y: state vector            - double array (6x1)
 
 param: parameters vector   - double array (5x1)
 
Output:

dydt: state rate of change - double array (6x1)


### rhs_SIRG:

This function defines the system of ODEs for the SIRG epidemic model.

The dynamic state coordinates are:
  
  S = susceptibles        (number of individuals)
  
  I = infected            (number of individuals)
 
  R = recovered           (number of individuals)
  
  G = guarded             (number of individuals)

The epidemic model parameters are:

 N     = population size (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 gamma = recovery rate     (days^-1)
 
 phi   = quantine-in rate  (days^-1)
 
 theta = quantine-out rate (days^-1)
 
 tq0   = quantine start (days)
 
 tq1   = quantine end (days)

Inputs:

 t: time                    - double
 
 y: state vector            - double array (5x1)
 
 param: parameters vector   - double array (7x1)
 
Output:

dydt: state rate of change - double array (5x1)



### rhs_SEIR(+AHD):

This function defines the system of ODEs for the SEIR(+AHD) epidemic model.

The dynamic state coordinates are:
  
  S = susceptibles            (number of individuals)
  
  E = exposed                 (number of individuals)
  
  I = infected                (number of individuals)
 
  R = recovered               (number of individuals)
  
  A = asymptomatic infectious (number of individuals)
  
  H = hospitalized            (number of individuals)
  
  D = deceased                (number of individuals)
  
  C = cumulative infected     (number of individuals)

The epidemic model parameters are:

 N0     = initial population size (number of individuals)
 
 beta   = transmission rate       (days^-1)
 
 alpha  = latent rate             (days^-1)
 
 fE     = symptomatic fraction    (dimensionless)
 
 gamma  = recovery rate           (days^-1)
 
 rho    = hospitalization rate    (days^-1)
  
 delta  = death rate              (days^-1)
 
 kappaH = hospitalization mortality-factor   (dimensionless)

Inputs:

 t: time                    - double
 
 y: state vector            - double array (8x1)
 
 param: parameters vector   - double array (8x1)
 
Output:

dydt: state rate of change - double array (8x1)

