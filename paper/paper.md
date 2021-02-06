---
title: 'EPIDEMIC: Epidemiology Educational Code'
tags:
  - epidemiology
  - compartmental models
  - educational code
  - Octave 
  - forecast and trend graphs
authors:
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1" 
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1" 
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1" 
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"
  - name: Adrian M. Price-Whelan^[corresponding author.]
    orcid: 0000-0003-0872-7098
    affiliation: "1"  
affiliations:
 - name: Lyman Spitzer, Jr. Fellow, Princeton University
   index: 1
 - name: Institution Name
   index: 2
 - name: Independent Researcher
   index: 3
 - name: Independent Researcher
   index: 4
 - name: Independent Researcher
   index: 5
date: 06 February 2021
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

![Illustration of the EPIDEMIC code logo.]

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



  [1]: #files {reference-type="ref" reference="files"}

[^1]: [www.EpidemicCode.org]

  [Illustration of the EPIDEMIC code logo.]: EPIDEMIC_Logo_R01.pdf
  {#modules}
  [www.EpidemicCode.org]: www.EpidemicCode.org

---
bibliography:
- paper.bib
---
