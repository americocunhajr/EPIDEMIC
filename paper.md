---
title: 'EPIDEMIC: Epidemiology Educational Code'
tags:
  - epidemiology
  - compartmental models
  - educational code
  - XXXXXX 
  - XXXXXX
authors:
  - name: Adrian M. Price-Whelan^[Custom footnotes for e.g. denoting who the corresponding author is can be included like this.]
    orcid: 0000-0003-0872-7098
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
  - name: Author Without ORCID
    affiliation: 2
  - name: Author with no affiliation
    affiliation: 3
affiliations:
 - name: Lyman Spitzer, Jr. Fellow, Princeton University
   index: 1
 - name: Institution Name
   index: 2
 - name: Independent Researcher
   index: 3
date: 30 August 2020
bibliography: paper.bib

# Optional fields if submitting to a AAS journal too, see this blog post:
# https://blog.joss.theoj.org/2018/12/a-new-collaboration-with-aas-publishing
aas-doi: 10.3847/xxxxx <- update this with the DOI from AAS once you know it.
aas-journal: Astrophysical Journal <- The name of the AAS journal.
---

Computational Epidemiology
==========================

An epidemic arises in a community or region when cases of illness or
other health-related events occur beyond normal expectations
[@Computationalepidemiology2013]. For many years, there have been
reports of several epidemics that have hit society and with the
emergence of new diseases, such as HIV/AIDS and hepatitis C, interest in
infectious diseases has increased a lot in recent years. The science
that studies epidemics and aims to analyze the distribution of phenomena
related to diseases and their conditioning and determining factors in
populations is called epidemiology. The aim of epidemiology is to
understand the causes of a disease in order to predict its evolution and
then make decisions to contain the epidemic. Thus, epidemiology is of
great importance to society. For epidemiology to reach its objective, it
is necessary to obtain and analyze disease data, requiring the use of
mathematical tools. Daniel Bernoulli's [@Brauer2017] work on smallpox is
generally described as the first model in mathematical epidemiology. In
[@hamer1906] was proposed that the spread of a communicable disease
depends on the number of susceptible and infected individuals, this
being the basic idea for the study of compartmental models in
epidemiology. In [@ross1911] was developed a simple compartmental model on the dynamics of malaria transmission
between mosquitoes and humans, and showed that to contain the spread a
reduction in the mosquito population below a critical level would be
sufficient. This was the introduction of the basic reproduction number
$(\mathcal{R}_0)$ concept. In Kermack and McKendrick
[@Kermack1927; @Kermack1932; @Kermack1933] was assumed that the
compartments are distributed exponentially. It is known that at the
beginning of a disease outbreak, there is a very small number of
infectious individuals and the transmission of the infection is a
stochastic event depending on the pattern of contacts between the
population, making it necessary to consider stochastic epidemiological
models.

The study of the spread of a disease leads to the generation of large
data sets that require the use of computational methods to generate
epidemiological models and analyze results for decision making
[@Tameru2012TheRO]. In this context, computational epidemiology arises,
which over time has become increasingly multidisciplinary (techniques of
epidemiology, biology, mathematics, theoretical computer science,
machine learning, etc.) and led to the development of new computational
methods to understand and control the spread of disease
[@RecentAdvances2013].
Statement of Need
=================

The COVID-19 pandemic in Brazil was above average compared to other
countries. With this, several researchers from different Brazilian
institutions developed COVID-19: Observatório Fluminense (COVID19RJ)
[@covid19-rj], Which aims to monitor progress, make predictions and
provide educational materials about COVID-19. To support the research
carried out in the COVID-19RJ project, the EPIDEMIC was developed,
because through this code it is possible to generate monitoring
graphics, trends and disease forecasts. In the context of the COVID-19
pandemic, it was observed that computational epidemiology gained
prominence, attracting the interest of many people from different areas
of knowledge. There are excellent codes available for conducting
epidemiological simulations, but these are customized for researchers in
the area
[@simcovid; @adhikari2020inference; @DANTAS2018249; @EpiFire; @Rebecca2020],
so members of COVID-19RJ felt the need to organize EPIDEMIC in a
pedagogical way, to collaborate in the training of new researchers.
Thus, in addition to EPIDEMIC being a research tool, it is an
easy-to-use tool that provides a detailed tutorial with several
examples, facilitating the insertion of new researchers in the field of
epidemiology.

EPIDEMIC Code
=============

The EPIDEMIC code is suitable for analyzing indicators of the evolution
of an epidemic, instructing in the analysis of forecasts and limitations
of each approach and providing a didactic and intuitive tool for
interested audiences. EPIDEMIC was developed on the free software
platform GNU Octave [@octave] and is available on a website[^1], where
you can find the code link in the GitHub repository. The EPIDEMIC code
is also compatible with MATLAB proprietary software. The fact that
EPIDEMIC is an open package, allows the user to better understand the
mathematical structure of the model and is accessible to a large
audience.The EPIDEMIC code structure consists of three modules:
modeling, trends and forecasts.

![EPIDEMIC code logo.]

[^1]: www.epidemiccode.org

  [EPIDEMIC code logo.]: figs/EPIDEMIC_Logo_R01.pdf {#modules}

Modeling
--------

In the modeling module, compartmental models, described by differential
equations, are used to simulate population dynamics during an epidemic.
The compartmental models available are: SIR, SEIR, SEIRD and SEIAHRD.
The SIR and SEIR models are simpler and more widely known. On GitHub it
is possible to find several codes that include the SIR and SEIR models,
but none of them are organized in modules (modeling, trends and
forecasts) and have an educational sense. Besides that, the EPIDEMIC
presents examples of more complex compartmental models.

In the SIR model, the compartments considered are: susceptible, infected
and recovered. In Figure [1] it is possible to observe a schematic
representation of the SIR model, where $\beta$ is transmission rate and
$\gamma$ is recovery rate. The basic reproduction number is
$\mathcal{R}_0 = \frac{\beta}{\gamma}$.

![Schematic representation of the SIR model.]

The differential equations, as a function of time, for the dynamics of
the SIR model are:

$$\begin{aligned}
\diff{S}{t} &= -\beta\,S\,\frac{I}{N} \,          \quad &&\textbf{(rate of susceptible)}\,,\\[3mm]
\diff{I}{t} &= \beta\,S\,\frac{I}{N} - \gamma\,I\,\quad &&\textbf{(rate of infected)}\,,\\[3mm]
\diff{R}{t} &= \gamma\,I \,                       \quad &&\textbf{(rate of recovered)}\,.\\[3mm]
\end{aligned}$$

In the SEIR model, the compartments considered are: susceptible,
exposed, infected and recovered. The SEIRD model has the addition of the
deceased compartment. In the SEIAHRD model, the compartments that are
considered to be more than those already mentioned are: asymptomatic,
infectious and hospitalized.

It is possible with EPIDEMIC to plot the curves of the aforementioned
compartmental models and thus analyze the epidemiological dynamics. To
do this, just change the values of the parameters of the epidemic that
you want to analyze in the code. It is also possible to carry out
analyzes, for example, of $\mathcal{R}_0$ in relation to $\beta$, or
else of the number of deaths in relation to $\beta$.

  [1]: #SIRmodel {reference-type="ref" reference="SIRmodel"}
  [Schematic representation of the SIR model.]: figs/esquemaSIR.pdf
  {#SIRmodel}

Trends
------

In the trends module, it is possible to monitor, through graphic
resources, the behavior of epidemics in countries, states or cities. The
analyzes are performed using two basic visualization strategies: that of
contagion and mortality and the progress of the epidemic. In Table [1]
it is possible to observe the types of graphs that can be generated in
the trends module.

::: {#graphtrends}
     Graph type                           Presented data
  -------------------- -----------------------------------------------------------------------
  Accumulated deaths            absolute value (total deaths per time)
  Accumulated cases             absolute value (total cases per time)
  Death progress                absolute value (new deaths per total deaths)
  Case progress                 absolute value (new cases per total cases)
  Weekly deaths                 absolute value (new deaths per time)
  Weekly cases                  absolute value (new cases per time)
  Mortality                     per million inhabitants ( total deaths per million)
  Prevalence                    per million inhabitants ( total cases per million over time)
  Weekly deaths                 per million inhabitants ( new weekly deaths per million )
  Incidence                     per million inhabitants ( new weekly cases per million)

  : Types of graphics generated by EPIDEMIC in the trends module.
:::

  [1]: #graphtrends {reference-type="ref" reference="graphtrends"}

Forecasts
---------

In the forecasts module, a statistical regressor is used to obtain
forecasts about the short term behavior of the epidemic curves. The
method used to obtain the regressor is the classic *Ordinary Least
Squares* [@Neter1996]. In preparing the forecasting code, the following
points were taken into account:

-   Consider the last five days of the data sample, as these reflect the
    most recent trend;

-   Insert the last five days on the logarithmic scale, as it
    facilitates visualization in case of exponential growth;

-   Plot the predicted values within the estimated reliability envelope.
    Confidence band is 95%.

Implementation
--------------

For the epidemic implementation, the package includes the files that are
described in Table [1]. In the name of the files in the modeling module,
the \"X\" represents the compartmental model (SIR, SEIR, SEIRD and
SEIAHRD). To facilitate its use, EPIDEMIC has a tutorial with examples
and explanations about the code.

::: {#files}
   Module                File                                      Description
  ----------- ------------------- ----------------------------------------------------------
  Modeling                        Main file. Defines the parameters and calculates the
                                  
                                  rhs_X.m
  Trends      epidemic_trends.m   Main file to generate graphs on the numbers of cases and
                                  
  Forecasts                       Main file to generate the forecast graphs of accumulated
                                  

  : EPIDEMIC package files.
:::

This educational code proves to be an important didactic tool for
epidemiological analysis, as it is available in a transparent,
accessible and reproducible way [@towards]. Therefore, it is also an
important tool for the development of research.

  [1]: #files {reference-type="ref" reference="files"}

---
bibliography:
- paper.bib
---
