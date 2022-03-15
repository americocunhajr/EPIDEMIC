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

## Codes of the compartmental models of the module Modeling 

### main_SIR

 This is a main file for the SIR epidemic model, which divides a population in 3 compartments:
 
 S = susceptible
 
 I = infected
 
 R = recovered

 Infection spreads via direct contact between a susceptible and infected individual, with no delay. No deaths are considered, all infected become recovered.
 
 This model has 3 parameters:

 N     = population size   (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 gamma = recovery rate     (days^-1)

 This code uses rhs_SIR.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale.

  Inputs:
  
  param: parameters vector      - double array (3x1)
  
  IC: initial conditions vector - double array (4X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SIR: SIR equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
  ### main_SIR_Brauer

 This is a main file for the SIR epidemic model, which divides a population in 3 compartments:
 
 S = susceptible
 
 I = infected
 
 R = recovered

 Infection spreads via direct contact between a susceptible and infected individual, with no delay. No deaths are considered, all infected become recovered.
 
 This model has 3 parameters:

 N     = population size   (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 gamma = recovery rate     (days^-1)

 This code uses rhs_SIR.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale. The conditions simulated by this file was esctrated from the New York City measles discrebed in F. Brauer, P. van den Driessche and J. Wu (eds.)  Mathematical epidemiology, Springer-Verlag, Berlin, 2008, p.5-11. DOI: https://doi.org/10.1007/978-3-540-78911-6 

  Inputs:
  
  param: parameters vector      - double array (3x1)
  
  IC: initial conditions vector - double array (4X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SIR: SIR equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
  ### main_SEIR

 This is a main file for the SEIR epidemic model, which divides a population in 4 compartments:
 
 S = susceptible
 
 E = exposed
  
 I = infected
 
 R = recovered

 Infection spreads via direct contact between a susceptible and infectious individual. Delay is modeled as an exposed group: there is an latent period until an infected becomes able to transmit (infectious). No deaths are considered, all infected become recovered.
 
 This model has 4 parameters:

 N     = population size   (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 alpha = latent rate       (days^-1)
 
 gamma = recovery rate     (days^-1)

  This code uses rhs_SEIR.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale.

  Inputs:
  
  param: parameters vector      - double array (4x1)
  
  IC: initial conditions vector - double array (5X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SEIR: SEIR equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
   ### main_SEIR_Dantas

 This is a main file for the SEIR epidemic model, which divides a population in 4 compartments:
 
 S = susceptible
 
 E = exposed
  
 I = infected
 
 R = recovered

 Infection spreads via direct contact between a susceptible and infectious individual. Delay is modeled as an exposed group: there is an latent period until an infected becomes able to transmit (infectious). No deaths are considered, all infected become recovered.
 
 This model has 4 parameters:

 N     = population size   (number of individuals)
 
 beta  = transmission rate (days^-1)
 
 alpha = latent rate       (days^-1)
 
 gamma = recovery rate     (days^-1)

  This code uses rhs_SEIR.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale. The conditions simulated by this file was estrated from the Brazil's zika outbreak discrebed in E. Dantas, M. Tosin and A. Cunha Jr, Calibration of a SEIR–SEI epidemic model  to describe the Zika virus outbreak in Brazil, Applied Mathematics and Computation, 338, p.249-259, 2020. DOI: https://doi.org/10.1016/j.amc.2018.06.024

  Inputs:
  
  param: parameters vector      - double array (4x1)
  
  IC: initial conditions vector - double array (5X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SEIR: SEIR equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
  
  ### main_SEIRD

 This is a main file for the SEIR epidemic model, which divides a population in 5 compartments:
 
 S = susceptible
 
 E = exposed
  
 I = infected
 
 R = recovered
 
 D = deceased

 Infection spreads via direct contact between a susceptible and infectious individual. Delay is modeled as an exposed group: there is an latent period until an infected becomes able to transmit (infectious). Disease-related deaths are considered when infectious.
 
 This model has 5 parameters:

  N0    = initial population size   (number of individuals)
  
  beta  = transmission rate         (days^-1)
  
  alpha = latent rate               (days^-1)
  
  gamma = recovery rate             (days^-1)
  
  delta = death rate                (days^-1)
  
 This codes uses rhs_SEIRD.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale.
 
 Inputs:
  
  param: parameters vector      - double array (5x1)
  
  IC: initial conditions vector - double array (6X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SEIRD: SEIRD equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
  
  ### main_SEIRD_ebola

 This is a main file for the SEIR epidemic model, which divides a population in 5 compartments:
 
 S = susceptible
 
 E = exposed
  
 I = infected
 
 R = recovered
 
 D = deceased

 Infection spreads via direct contact between a susceptible and infectious individual. Delay is modeled as an exposed group: there is an latent period until an infected becomes able to transmit (infectious). Disease-related deaths are considered when infectious.
 
 This model has 5 parameters:

  N0    = initial population size   (number of individuals)
  
  beta  = transmission rate         (days^-1)
  
  alpha = latent rate               (days^-1)
  
  gamma = recovery rate             (days^-1)
  
  delta = death rate                (days^-1)
  
 This codes uses rhs_SEIRD.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale. The parameters used in this example were taken from this work: P. Diaz, P. Constantine, K. Kalmbach, E. Jones and S. Pankavichm. A modified SEIR model for the spread of Ebolain Western Africa and metrics for resource allocation, Applied Mathematics and Computation, 324(1): 141-155, 2018
 
 Inputs:
  
  param: parameters vector      - double array (5x1)
  
  IC: initial conditions vector - double array (6X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SEIRD: SEIRD equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
  
 ### main_SIRG

 This is the main file for a economic-epidemic coupled dynamic model, which divides a population in 4 compartments:

 S = susceptible
  
 I = infected
 
 R = recovered
 
 G = guarded

 Infection spreads via direct contact between a susceptible and infected individual, with no delay. No deaths are considered, all infected become recovered.
 
 This model has 7 parameters:

   N     = population size   (number of individuals)
   
   beta  = transmission rate (days^-1)
   
   gamma = recovery rate     (days^-1)
   
   phi   = quantine-in rate  (days^-1)
   
   theta = quantine-out rate (days^-1)
   
   tq0   = quantine start (days)
   
   tq1   = quantine end (days)
  
  This codes uses rhs_SIRG.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale.
 
 Inputs:
  
  param: parameters vector      - double array (4x1)
  
  IC: initial conditions vector - double array (5X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SIRG: SIRG equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure


 ### main_SIRG_example

 This is the main file for a economic-epidemic coupled dynamic model, which divides a population in 4 compartments:

 S = susceptible
  
 I = infected
 
 R = recovered
 
 G = guarded

 Infection spreads via direct contact between a susceptible and infected individual, with no delay. No deaths are considered, all infected become recovered.
 
 This model has 7 parameters:

   N     = population size   (number of individuals)
   
   beta  = transmission rate (days^-1)
   
   gamma = recovery rate     (days^-1)
   
   phi   = quantine-in rate  (days^-1)
   
   theta = quantine-out rate (days^-1)
   
   tq0   = quantine start (days)
   
   tq1   = quantine end (days)
  
  This codes uses rhs_SIRG.m to define the ODE system and outputs the plots and R_nought value. Calculations are made on a day time scale. In this example the quarantine starts at tq0 = 0 and ends at tq1 = 101. The time interval of analysis is t0=1 and t1=100, therefore, the quarantine remains throughout the interval of analysis.
 
 Inputs:
  
  param: parameters vector      - double array (4x1)
  
  IC: initial conditions vector - double array (5X1)
  
  tspan: time interval          - double array (?x1)
  
  rhs_SIRG: SIRG equations file   - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure

 ### main_SEIRAHD

 This is a main file for the the SEIR(+AHD) epidemic model, which divides a population in 7 compartments:
 
 S = susceptible
 
 E = exposed
  
 I = symptomatic infectious
 
 A = asymptomatic infectious
 
 H = hospitalized
 
 R = recovered
 
 D = deceased

 Infection spreads via direct contact between a susceptible and infectious individual. Delay is modeled as an exposed group: there is an latent period until an infected becomes able to transmit. Among the infectious, most individuals are asymptomatic; only a small fraction display symptoms after incubation. Disease-related deaths are considered when infectious. A control procedure is considered: a fraction of the infectious, is hospitalized, thus reducing their infectivity and fatality chance.
 
 This model has 9 parameters:

  N0       = initial population size            (number of individuals)
  
  beta     = transmission rate                  (days^-1)
  
  alpha    = latent rate                        (days^-1)
  
  fE       = symptomatic fraction               (dimensionless)
  
  gamma    = recovery rate                      (days^-1)
  
  rho      = hospitalization rate               (days^-1)
  
  delta    = death rate                         (days^-1)
  
  kappaH   = hospitalization mortality-factor   (dimensionless)
  
 This codes uses rhs_SEIRAHD.m to define the ODE system and outputs the plots, R_nought value and R_control value. Calculations are made on a day time scale.
 
 Inputs:
  
 param: parameters vector            - double array (9x1)
 
 IC: initial conditions vector       - double array (8X1)
 
 tspan: time interval                - double array (?x1)
  
 rhs_SEIRAHD: SEIRAHD equations file - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
### main_SEIRAHD_covid

 This is a main file for the SEIR(+AHD) epidemic model, which divides a population in 7 compartments:
 
 S = susceptible
 
 E = exposed
  
 I = symptomatic infectious
 
 A = asymptomatic infectious
 
 H = hospitalized
 
 R = recovered
 
 D = deceased

 Infection spreads via direct contact between a susceptible and infectious individual. Delay is modeled as an exposed group: there is an latent period until an infected becomes able to transmit. Among the infectious, most individuals are asymptomatic; only a small fraction display symptoms after incubation. Disease-related deaths are considered when infectious. A control procedure is considered: a fraction of the infectious, is hospitalized, thus reducing their infectivity and fatality chance.
 
 This model has 9 parameters:

  N0       = initial population size            (number of individuals)
  
  beta     = transmission rate                  (days^-1)
  
  alpha    = latent rate                        (days^-1)
  
  fE       = symptomatic fraction               (dimensionless)
  
  gamma    = recovery rate                      (days^-1)
  
  rho      = hospitalization rate               (days^-1)
  
  delta    = death rate                         (days^-1)
  
  kappaH   = hospitalization mortality-factor   (dimensionless)
  
 This codes uses rhs_SEIRAHD.m to define the ODE system and outputs the plots, R_nought value and R_control value. Calculations are made on a day time scale. The parameters used in this example were taken from this work. W. Lyra, J. Nascimento, J. Belkhiria, L. de Almeida, P. P. Chrispim and I. Andrade.COVID-19 pandemics modelingwith SEIR(+CAQH), social distancing, and age stratification. The effect of vertical confinement and release in Brazil.,medRxiv, 2020.
 
 Inputs:
  
 param: parameters vector            - double array (9x1)
 
 IC: initial conditions vector       - double array (8X1)
 
 tspan: time interval                - double array (?x1)
  
 rhs_SEIRAHD: SEIRAHD equations file - .m function file

  Outputs:
  
  R_nought: basic reproduction number   - double
  
  figure 1: model state in time         - inplace figure
  
  figure 2: number of new cases in time - inplace figure
  
