---
title: 'EPIDEMIC: Epidemiology Educational Code'
tags:
  - epidemiology
  - educational code
  - compartmental models
  - Octave
  - trend and forecast graphs
authors:
  - name: Bruna Pavlack
    orcid: 0000-0002-6807-0916
    affiliation: "3,4"
  - name: Malú Grave 
    orcid: 0000-0002-7697-0658
    affiliation: 2
  - name: Eber Dantas
    orcid: 0000-0003-2693-0719
    affiliation: 2
  - name: Julio Basilio
    orcid: 0000-0003-1040-735X
    affiliation: 1
  - name: Leonardo de la Roca
    orcid: 0000-0003-2896-228X
    affiliation: 1
  - name: João Pedro Norenberg
    orcid: 0000-0003-3558-4053
    affiliation: 3
  - name: Michel Tosin 
    orcid: 0000-0002-0112-553X
    affiliation: 1
  - name: Lucas Chaves
    orcid: 0000-0003-4567-2006
    affiliation: 5
  - name: Diego Matos
    orcid: 0000-0002-6711-8500
    affiliation: 1
  - name: Marcos Issa
    orcid: 0000-0002-2811-4929
    affiliation: 1
  - name: Roberto Luo
    orcid: 0000-0002-3822-4945
    affiliation: 1 
  - name: Amanda Cunha Guyt
    orcid: 0000-0001-8575-3594
  - name: Luthiana Soares
    orcid: 0000-0001-5314-0881
  - name: Rodrigo Burgos
    orcid: 0000-0003-0326-395X
    affiliation: 1 
  - name: Lisandro Lovisolo
    orcid: 0000-0002-7404-9371
    affiliation: 1
  - name: Americo Cunha Jr^[corresponding author.]
    orcid: 0000-0002-8342-0363
    affiliation: 1 
affiliations:
  - name: Rio de Janeiro State University
    index: 1
  - name: Federal University of Rio de Janeiro
    index: 2
  - name: State University of São Paulo
    index: 3
  - name: Federal Institute of Mato Grosso do Sul
    index: 4
  - name: Federal University of Uberlândia
    index: 5
date: 6 February 2021
bibliography: paper.bib

---

# Computational epidemiology

The aim of epidemiology is to understand the causes of a disease in
order to predict its evolution and then make decisions to contain the
epidemic. Thus, epidemiology is of great importance to society.

The study of the spread of a disease leads to the generation of large
data sets that require the use of computational methods to generate
epidemiological models and analyze results for decision making
[@Tameru:2012]. In this context, computational epidemiology arises,
which over time has become increasingly multidisciplinary (techniques of
epidemiology, biology, mathematics, theoretical computer science,
machine learning, etc.) and led to the development of new computational
methods to understand and control the spread of disease [@Marathe:2013].

# Statement of need

Due to the Covid-19 pandemic, several researchers from different
Brazilian institutions organized an initiative called *COVID-19:
Observatório Fluminense* (COVID-19RJ) [@covid19-rj], which aims to
monitor the pandemic progress in Brazil, make reliable predictions about
the short term evolution and provide high-quality educational material
about the mathematical modeling and analysis of COVID-19. To support the
research carried out in the COVID-19RJ project, the EPIDEMIC was
developed, because through this code it is possible to generate
monitoring graphics, trends and disease forecasts. The EPIDEMIC is cited
in the reports of the COVID-19RJ project.

In the context of the COVID-19 pandemic, it was observed that
computational epidemiology gained prominence, attracting the interest of
many people from different areas of knowledge. There are excellent codes
available for conducting epidemiological simulations, but these are
customized for researchers in the area
[@Abdulrahman:2020; @Adhikari:2020; @Dantas:2018; @Hladish:2012; @Morrison:2020],
so members of COVID-19RJ felt the need to organize EPIDEMIC in a
pedagogical way, to collaborate in the training of new researchers.
Thus, in addition to EPIDEMIC being a research tool, it is an
easy-to-use tool that provides a detailed tutorial with several
examples, facilitating the insertion of new researchers in the field of
epidemiology.

# EPIDEMIC code

The EPIDEMIC code is a suite of basic software for epidemiology that is
suitable for analyzing indicators of an epidemic evolution as well as to
construct basic compartment models for qualitative and quantitative
analysis. It is developed in an easy to use style, with with very lean
and well-documented codes. The package also includes an instructional
tutorial that gives the end user information about the type of analysis
and forecasts that can be obtained with the suite, as well as an
overview of the limitations of each model available in the code. The
EPIDEMIC code is a didactic and intuitive pedagogical tool for audiences
interested in mathematical epidemiology. The EPIDEMIC is developed on
the free software platform GNU Octave [@Eaton:2002] and is available on
a website[^1], where one can find a GitHub repository link that directs
to the suite source code. The EPIDEMIC code is also compatible with
MATLAB proprietary software. The fact that EPIDEMIC is an open package,
allows the user to better understand the mathematical structure of the
model and is accessible to a large audience. The EPIDEMIC code structure
consists of three modules: modeling, trends and forecasts.

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
else of the number of deaths in relation to $\beta$.

## Trends

In the trends module, it is possible to monitor, through graphic
resources, the behavior of epidemics in countries, states or cities. The
analyzes are performed using two basic visualization strategies: that of
contagion and mortality and the progress of the epidemic. The types of
graphs that can be generated in the trends module are: accumulated
deaths, accumulated cases, death progress, case progress, weekly deaths,
weekly cases, mortality, prevalence, weekly deaths, and incidence.

## Forecasts

In the forecasts module, a statistical regressor is used to obtain
forecasts about the short term behavior of the epidemic curves. The
method used to obtain the regressor is the classic *Ordinary Least
Squares* [@Neter:1996]. In preparing the forecasting code, the following
points were taken into account:

- Consider the last five days of the data sample, as these reflect the most recent trend;

- Insert the last five days on the logarithmic scale, as it facilitates visualization in case of exponential growth;

- Plot the predicted values within the estimated reliability envelope. Confidence band is 95%.

## Implementation

For the epidemic implementation, in the modeling module, the package
includes the files *main_X.m* and *rhs_X.m*. The \"X\" in the name
represents the compartmental model (SIR, SEIR, SIRG, SEIRD, and
SEIAHRD). The file *main* defines the parameters and calculates the
reproduction numbers and plots the results of the time series. The file
*rhs* defines the ODE system used by the main file. In the trends module
there is the file *epidemic_trends.m*, which is the main file to
generate graphs on the numbers of cases and deaths by epidemic in the
countries of interest. And in the forecasts module there is the file
*epidemic_forecasts.m*, which is the main file to generate the forecast
graphs of accumulated cases and accumulated deaths from an epidemic.

To check the restrictions on the use of EPIDEMIC routines, the \"test\"
folder brings together a set of \"verification scripts\" to individually
cover each possible error in these routines. To facilitate its use,
EPIDEMIC has a tutorial with examples and explanations about the code.

This educational code proves to be an important didactic tool for
epidemiological analysis, as it is available in a transparent,
accessible and reproducible way [@Chatterjee:2020]. Therefore, it is
also an important tool for the development of research.

[^1]: [www.EpidemicCode.org]

  [www.EpidemicCode.org]: www.EpidemicCode.org
  
  [Illustration of the EPIDEMIC code logo and EPIDEMIC modules.]: figEPIDEMIC.pdf
  {#modules}


# References

