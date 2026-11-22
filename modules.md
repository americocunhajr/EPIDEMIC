---
layout: default
title: "EPIDEMIC Modules — SIR, SEIR and Epidemiology MATLAB/Octave Tutorials"
description: "Explore EPIDEMIC educational code for SIR, SEIR, SEIRD, SIRG, and SEIRAHD compartmental models, epidemic trends and short-term forecasts in MATLAB and GNU Octave."
permalink: /modules/
---

# EPIDEMIC: computational epidemiology modules and tutorials

**EPIDEMIC (Epidemiology Educational Code)** is a free, open-source MATLAB and GNU Octave toolkit for students, teachers and researchers learning computational epidemiology. It provides three independent modules: **Modeling**, **Trends**, and **Forecasts**, together with tutorials in English and Portuguese.

[Project homepage](https://www.epidemiccode.org/) · [GitHub source code](https://github.com/americocunhajr/EPIDEMIC) · [English tutorial (PDF)](https://github.com/americocunhajr/EPIDEMIC/blob/master/Docs/EPIDEMIC_Tutorial_EN.pdf) · [Portuguese tutorial (PDF)](https://github.com/americocunhajr/EPIDEMIC/blob/master/Docs/EPIDEMIC_Tutorial_PT.pdf)

## 1. Modeling: differential-equation compartmental epidemic models

The [Modeling directory](https://github.com/americocunhajr/EPIDEMIC/tree/master/modeling) contains introductory compartmental models implemented as ordinary differential equations. Each model includes a main simulation script (`main_*.m`), equations of motion (`rhs_*.m`), and supporting examples or checks.

### SIR — Susceptible, Infected and Recovered

[**SIR model**](https://github.com/americocunhajr/EPIDEMIC/tree/master/modeling/SIR): the classical susceptible–infected–recovered model of transmission and recovery. Start with `main_SIR.m`; `rhs_SIR.m` defines the differential equations.

### SEIR — Susceptible, Exposed, Infected and Recovered

[**SEIR model**](https://github.com/americocunhajr/EPIDEMIC/tree/master/modeling/SEIR): adds an exposed (latent) compartment before infectiousness. Start with `main_SEIR.m` and `rhs_SEIR.m`.

### SEIRD — Including deaths

[**SEIRD model**](https://github.com/americocunhajr/EPIDEMIC/tree/master/modeling/SEIRD): extends the exposed–infected–recovered model with a deceased compartment. Start with `main_SEIRD.m` and `rhs_SEIRD.m`.

### SIRG — Including guarded individuals

[**SIRG model**](https://github.com/americocunhajr/EPIDEMIC/tree/master/modeling/SIRG): includes a guarded compartment to illustrate isolation/quarantine dynamics. Start with `main_SIRG.m` and `rhs_SIRG.m`.

### SEIRAHD — Symptomatic/asymptomatic infection and hospitalization

[**SEIRAHD scripts (in the SEIAHRD directory)**](https://github.com/americocunhajr/EPIDEMIC/tree/master/modeling/SEIAHRD) model susceptible, exposed, symptomatic infectious, recovered, asymptomatic infectious, hospitalized and deceased populations (with a cumulative-infections state). The source scripts are named `main_SEIRAHD.m` and `rhs_SEIRAHD.m`. The GitHub directory retains the historical name `SEIAHRD`.

These models are educational examples with simplifying assumptions. Parameter choices and model outputs should not be interpreted as validated epidemiological forecasts without further calibration and validation.

## 2. Trends: epidemiological data visualization

[**Trends module**](https://github.com/americocunhajr/EPIDEMIC/tree/master/trends) uses `epidemic_trends.m` to visualize case and death counts, weekly changes and population-normalized indicators. The source includes sample COVID-19 data files from Our World in Data for historical exercises.

The bundled CSV files are sample datasets, not an automatically maintained live surveillance feed.

## 3. Forecasts: short-term extrapolation

[**Forecasts module**](https://github.com/americocunhajr/EPIDEMIC/tree/master/forecasts) uses `epidemic_forecasts.m` to illustrate short-term projections for reported cases and deaths. Its documented demonstration fits a linear regression on logarithmic counts using a five-day window and produces five-day-ahead extrapolations with nominal 95% intervals.

This is a teaching example of statistical extrapolation, not an operational disease-forecasting service. The example contains historical case data, and forecast uncertainty is subject to model assumptions.

## Documentation and installation

Read the [English tutorial](https://github.com/americocunhajr/EPIDEMIC/blob/master/Docs/EPIDEMIC_Tutorial_EN.pdf) or the [Portuguese tutorial](https://github.com/americocunhajr/EPIDEMIC/blob/master/Docs/EPIDEMIC_Tutorial_PT.pdf). The [code documentation](https://github.com/americocunhajr/EPIDEMIC/blob/master/CODE%20DOCUMENTATION.md) describes the model state variables, parameters and functions in greater detail.

Clone the [GitHub repository](https://github.com/americocunhajr/EPIDEMIC) and open the relevant module folder in MATLAB or GNU Octave. Run the module's main script. The repository reports testing with GNU Octave 5.2.0 and MATLAB R2016b; compatibility with newer versions has not been verified here.

## Frequently asked questions

### What is EPIDEMIC?

A teaching-oriented MATLAB/Octave software collection for mathematical epidemic modeling, visualization of trends and basic statistical forecasting.

### Which mathematical models are included?

SIR, SEIR, SEIRD, SIRG and a more detailed SEIRAHD model with asymptomatic infections and hospitalization.

### Does EPIDEMIC require Python?

No. The published code is written for MATLAB and GNU Octave.

### Does EPIDEMIC offer tutorials in Portuguese?

Yes. The project includes full English and Portuguese tutorial PDFs.

### How should EPIDEMIC be cited?

**Pavlack et al. (2022)**, *EPIDEMIC: Epidemiology Educational Code*, *Journal of Open Source Education*, **5**(50), 149. DOI: [10.21105/jose.00149](https://doi.org/10.21105/jose.00149).
