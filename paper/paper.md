---
title: 'EPIDEMIC: Epidemiology Educational Code'
tags:
  - epidemiology teaching
  - educational code
  - computational models
  - compartmental models
  - trend and forecast graphs
authors:
  - name: Bruna Pavlack
    orcid: 0000-0002-6807-0916
    affiliation: "1,2"
  - name: Malú Grave 
    orcid: 0000-0002-7697-0658
    affiliation: 3
  - name: Eber Dantas
    orcid: 0000-0003-2693-0719
    affiliation: 3
  - name: Julio Basilio
    orcid: 0000-0003-1040-735X
    affiliation: 4
  - name: Leonardo de la Roca
    orcid: 0000-0003-2896-228X
    affiliation: 4
  - name: João Pedro Norenberg
    orcid: 0000-0003-3558-4053
    affiliation: 2
  - name: Michel Tosin 
    orcid: 0000-0002-0112-553X
    affiliation: 4
  - name: Lucas Chaves
    orcid: 0000-0003-4567-2006
    affiliation: 5
  - name: Diego Matos
    orcid: 0000-0002-6711-8500
    affiliation: 4
  - name: Marcos Issa
    orcid: 0000-0002-2811-4929
    affiliation: 4
  - name: Roberto Luo
    orcid: 0000-0002-3822-4945
    affiliation: 4
  - name: Amanda Cunha Guyt
    orcid: 0000-0001-8575-3594
    affiliation: 6
  - name: Luthiana Soares
    orcid: 0000-0001-5314-0881
    affiliation: 7
  - name: Rodrigo Burgos
    orcid: 0000-0003-0326-395X
    affiliation: 4
  - name: Lisandro Lovisolo
    orcid: 0000-0002-7404-9371
    affiliation: 4
  - name: Americo Cunha Jr^[Corresponding author (americo.cunha\@uerj.br).]
    orcid: 0000-0002-8342-0363
    affiliation: 4 
affiliations:
  - name: Federal Institute of Mato Grosso do Sul
    index: 1
  - name: State University of São Paulo
    index: 2
  - name: Federal University of Rio de Janeiro
    index: 3
  - name: Rio de Janeiro State University
    index: 4
  - name: Federal University of Uberlândia
    index: 5
  - name: City College of San Francisco
    index: 6
  - name: Federal University of Pampa
    index: 7
date: 4 June 2021
bibliography: paper.bib

---

# Computational epidemiology

The aim of epidemiology is to understand the causes of a disease in
order to predict its evolution and then make decisions to contain the
epidemic. Thus, epidemiology is of great importance to society.

The study of a disease spreading leads to the generation of large
data sets that requires the use of computational methods to generate
epidemiological models and analyze results for decision-making
[@Tameru2012]. In this context, computational epidemiology arises,
which over time has become increasingly multidisciplinary (techniques of
epidemiology, biology, mathematics, theoretical computer science,
machine learning, etc.) and led to the development of new computational
methods to understand and control the spread of disease [@Marathe2013].

# Statement of need

Due to the Covid-19 pandemic, several researchers from different
Brazilian institutions organized an initiative called *COVID-19:
Observatório Fluminense* (COVID-19RJ) [@covid19-rj], which aims to
monitor the pandemic progress in Brazil, make reliable predictions about
the short term evolution and provide high-quality educational material
about the mathematical modeling and analysis of COVID-19. To support the
research carried out in the COVID-19RJ project, EPIDEMIC was
developed, because through this code it is possible to generate
monitoring graphics, trends and disease forecasts. EPIDEMIC is cited
in the reports of the COVID-19RJ project.

In the context of the COVID-19 pandemic, it was observed that
computational epidemiology gained prominence, attracting the interest of
many people from different areas of knowledge. There are excellent codes
available for conducting epidemiological simulations, but these are
customized for researchers in the area
[@Abdulrahman2020; @Adhikari2020; @Dantas2018; @Hladish2012; @Morrison2020],
so members of COVID-19RJ felt the need to organize EPIDEMIC in a
pedagogical way, to collaborate in the training of new researchers.
Thus, in addition to EPIDEMIC being a research tool, it is an
easy-to-use code that provides a detailed tutorial with several
examples, facilitating the insertion of new researchers in the field of
epidemiology and also assisting in teaching courses on computational modeling and epidemiology.

In a mathematical biology course, for example, students are exposed to the derivation of equations 
from various compartmental models based on nonlinear differential equations, so that the vast majority 
have no analytical solution. In this context, there is a natural need to use numerical methods to obtain 
the answer from the mathematical model. Packages like GNU Octave and Matlab have very robust ordinary differential equations (ODEs) solvers that 
make this task much easier. EPIDEMIC tutorials provide pedagogical activities in this sense, as they illustrate,
via relatively streamlined and very well organized codes, how to perform the numerical integration of these models based on ODEs. 
The programming structure followed in the tutorial, with several compartmental models, also aims to show students how easy it 
is to carry out such numerical integration for another type of compartmental model that the student can find in the literature 
or develop himself/herself.

The benefits of EPIDEMIC tutorial go beyond the simple exercise of programming numerical integration, 
the analysis of the response curves of different models allows students to develop intuition about the dynamic 
behavior of dynamic epidemiological systems. For example, when seeing in the same figure the 3 curves of the SIR 
model (susceptible, infected and recovered), the student can see that the initial growth of an outbreak is
accompanied at the same time by a significant reduction in the number of susceptibles, being succeeded by an 
increase in the number of recovereds. An interesting analogy in this case that aids in the students' 
understanding is the following: be the infected as the intensity of a fire, the susceptible as the available firewood, 
and the recovered as the burnt firewood after a fire. At the beginning there is a lot of firewood available, 
a large fire ensues, then, as the firewood burns, the intensity of the fire decreases.

EPIDEMIC codes have already been used in a course on numerical and computational methods in Rio de Janeiro State University to present the 
part of polynomial regression and exponential curve fitting. In this course, the code was used on three fronts, 
according to EPIDEMIC modules: modeling, trends and forecast. In the module modeling, the compartmental models were 
presented as computer simulators, students run the codes as a black box to familiarize themselves with simulation basics,
and get acquainted with the Octave software. The code is also used in interpolation classes. We want to obtain a 
polynomial function that describes the number of infected people at the peak of the epidemic as a function of the transmission 
rate beta. Students simulate some cases by varying the beta parameter, obtaining some values for the number
of infected at peak. Then they interpolate polynomial curves to describe this functional relationship. Students are invited to 
reflect which polynomial is most representative, that is, which makes the most sense. The module trends was used in the data 
visualization class, to train students on how to show different information in a clear, objective, effective and graphically 
attractive way. In this exercise, the effect of normalizing was also shown, to remove the scaling effect of population size 
(eg infected vs time / infected by 1M inhab vs time), when normalizing the curves approach the same level, without local 
normalization of larger population has much larger numbers, which may not be true when normalizing. And, the module forecast was 
used to train the students in the regression part (curve fitting), they used the COVID-19 epidemic data as observations, 
and looked for polynomial and exponential curves that fit the start of the outbreak (exponential phase). Below is a brief description
of the code and modules that make up EPIDEMIC.

# EPIDEMIC code

EPIDEMIC code is a suite of basic software for epidemiology that is
suitable for analyzing indicators of an epidemic evolution as well as to
construct basic compartmental models for qualitative and quantitative
analysis. It is developed in an easy to use style, with very lean
and well-documented codes. The package also includes an instructional
tutorial that gives the end user information about the type of analysis
and forecasts that can be obtained with the suite, as well as an
overview of the limitations of each model available in the code. EPIDEMIC code is a didactic and intuitive pedagogical tool for audiences
interested in mathematical epidemiology. EPIDEMIC is developed on
the free software platform GNU Octave and is available on
a website[^1], where one can find a GitHub repository link that directs
to the suite source code. EPIDEMIC code is also compatible with
MATLAB proprietary software. The fact that EPIDEMIC is an open package,
allows the user to better understand the mathematical structure of the
model and is accessible to a large audience. The user should have previous knowledge of GNU Octave or MATLAB, but as the organization of EPIDEMIC code is done in a very didactic way, those students who have a first access to these programming languages will also be able to carry out the simulations. Figure [1] shows EPIDEMIC logo and the three EPIDEMIC modules: modeling, trends and forecasts.

![Illustration of the EPIDEMIC code logo and EPIDEMIC modules.] 

## Modeling

In the modeling module, compartmental models, described by differential
equations, are used to simulate population dynamics during an epidemic.
The compartmental models available are: SIR, SEIR, SIRG, SEIRD, and
SEIAHRD.

It is possible with EPIDEMIC to plot the curves of the aforementioned
compartmental models and thus analyze the epidemiological dynamics. To
do this, just change the values of the parameters of the epidemic that
you want to analyze in the code. It is also possible to carry out
analyzes, for example, of $\mathcal{R}_0$ in relation to $\beta$, or
else of the number of deaths in relation to $\beta$. Figure [2] shows an example time series graph of the SEIAHRD compartmental model.

![Time series graph of the SEIAHRD dynamic model generated in the modeling module of EPIDEMIC.]

## Trends

In the trends module, it is possible to monitor, through graphic
resources, the behavior of epidemics in countries, states or cities. The
analyzes are performed using two basic visualization strategies: that of
contagion and mortality and the progress of the epidemic. The types of
graphs that can be generated in the trends module are: accumulated
deaths, accumulated cases, death progress, case progress, weekly deaths,
weekly cases, mortality, prevalence, weekly deaths, and incidence. Figure [3] shows an 
example of a trend graph generated in EPIDEMIC. This graph shows the evolution of the total number of deaths per 1M inhabitants in several countries.

![Trend graph of total number of deaths per 1M inhabitants in several countries generated in EPIDEMIC.]

## Forecasts

In the forecasts module, a statistical regressor is used to obtain
forecasts about the short term behavior of the epidemic curves. The
method used to obtain the regressor is the classic *Ordinary Least
Squares*. In preparing the forecasting code, the following
points were taken into account:

- Consider the last five days of the data sample, as these reflect the most recent trend;
- Insert the last five days on the logarithmic scale, as it facilitates visualization in case of exponential growth;
- Plot the predicted values within the estimated reliability envelope. Confidence band is 95%.

Figure [4] shows a forecast graph of the total cases of COVID-19 in Brazil generated by EPIDEMIC. 

![Forecast graph of the total cases of COVID-19 in Brazil generated at EPIDEMIC. The gray color shows the 95% confidence band.]

## Implementation

For the epidemic implementation, in the modeling module, the package
includes the files *main_X.m* and *rhs_X.m*. The \"X\" in the name
represents the compartmental model (SIR, SEIR, SIRG, SEIRD, and
SEIAHRD). The file *main* defines the parameters and calculates the
reproduction numbers and plots the results of the time series. The File
*rhs* defines the ODE system used by the main file. In the trends module,
there is the file *epidemic_trends.m*, which is the main file to
generate graphs on the numbers of cases and deaths by epidemic in the
countries of interest. And in the forecasts module, there is the file
*epidemic_forecasts.m*, which is the main file to generate the forecast
graphs of accumulated cases and accumulated deaths from an epidemic.

To check the restrictions on the use of EPIDEMIC routines, the \"test\"
folder brings together a set of \"verification scripts\" to individually
cover each possible error in these routines. To facilitate its use,
EPIDEMIC has a tutorial, in English and Portuguese, with examples and explanations about the code.
The codes and the EPIDEMIC tutorial are constantly being updated, according to the needs that
come up.

This educational code proves to be an important didactic tool for
epidemiological analysis, as it is available in a transparent,
accessible and reproducible way [@Chatterjee2020]. Therefore, it is
also an important tool for the development of research.

[^1]: [www.EpidemicCode.org]

  [www.EpidemicCode.org]: www.EpidemicCode.org
  
  [Illustration of the EPIDEMIC code logo and EPIDEMIC modules.]: figEPIDEMIC.pdf
  {#logo width="90%"}
  
  [1]: #logo {reference-type="ref" reference="logo"}
  
  [Time series graph of the SEIAHRD dynamic model generated in the modeling module of EPIDEMIC.]:
    covid_SEIAHRD_Brasil2019.png {#figtimeseries width="85%"}
    
  [2]: #figtimeseries {reference-type="ref" reference="figtimeseries"}
  
   [Trend graph of total number of deaths per 1M inhabitants evolution of the COVID-19 pandemic in several countries generated in EPIDEMIC.]:
    mortality-pm_2020-05-16.png {#mortality-pm_2020-05-16 width="85%"}

  [3]: #mortality-pm_2020-05-16 {reference-type="ref" reference="mortality-pm_2020-05-16"}
  
  [Forecast graph of the total cases of COVID-19 in Brazil generated at EPIDEMIC. The gray color shows the 95% confidence band.]:
    forecasts-cases.png {#forecasts-cases width="85%"}

  [4]: #forecasts-cases {reference-type="ref" reference="forecasts-cases"}

  
# References
