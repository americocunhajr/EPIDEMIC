<img src="logo/EPIDEMIC.png" width="50%">

**EPIDEMIC - Epidemiology Educational Code** is an easy-to-run educational Matlab toolkit for epidemiological analysis, which offers functionalities for modeling an epidemic, monitoring its progress and forecasting the underling numbers of interest. This code is, first of all, an educational tool for researchers and students who are interested in computational epidemiology. The programs and tutorials are designed to offer good introductory material for beginners in the field. But they can also be used to analyze epidemic data, as well as in the construction of some simplistic epidemic models. The package is structured in 3 independent modules:
- **Modeling:** which uses differential equation-based compartmental models to emulate the dynamic behavior of homogeneous populations during an epidemic scenario;
- **Trends:** which uses several types of trend graphs to analyze the dynamic behavior of an epidemic as well as its underlyng rate of progress;
- **Forecasts:** which uses data-driven statistical regressors to make short-term predictions about certain quantities of interest underlying the epidemic.

The current stable version of **EPIDEMIC** is available on GitHub:

https://github.com/americocunhajr/EPIDEMIC


This package includes the following files:

**MODELING:**

- main_SIR.m
- rhs_SIR.m 
- main_SEIR.m
- rhs_SEIR.m 
- main_SEIRD.m
- rhs_SEIRD.m 
- main_SEIAHRD.m
- rhs_SEIAHRD.m 

**TRENDS:**
- epidemic_trends.m

**FORECASTS:**
- epidemic_forecast.m

## Tutorial

A tutorial style user guide for **EPIDEMIC** is available in English and Portuguese:

[EPIDEMIC_Tutorial_EN.pdf](https://github.com/americocunhajr/EPIDEMIC/blob/master/Docs/EPIDEMIC_Tutorial_EN.pdf)

[EPIDEMIC_Tutorial_PT.pdf](https://github.com/americocunhajr/EPIDEMIC/blob/master/Docs/EPIDEMIC_Tutorial_PT.pdf)



## Octave/Matlab compatibility

**EPIDEMIC** was developed to be 100% compatible with the Octave and Matlab platforms.

## Team:

**Faculty/Researchers:**
- Americo Cunha
- Lisandro Lovisolo
- Malú Grave
- Rodrigo Burgos

**Students:**
- Bruna Pavlack
- Diego Matos
- Eber Dantas
- João Pedro Norenberg
- Julio Basilio
- Leonardo de la Roca
- Lucas Chaves
- Marcos Vinicius Issa
- Michel Tosin
- Roberto Luo

**Design:**
- Amanda Cunha Guyt
- Luthiana Soares


## Citing EPIDEMIC

We ask users to cite the following manual in any publications reporting work done with **EPIDEMIC**:
- B. Pavlack et al. EPIDEMIC - Epidemiology Educational Code, 2021 www.EpidemicCode.org

```
@misc{EPIDEMIC2021,
   author       = {B. {Pavlack et al.}},
   title        = { {EPIDEMIC} - {E}pidemiology {E}ducational {C}ode},
   year         = {2021},
   publisher    = {GitHub},
   journal      = {GitHub repository},
   howpublished = {\url{www.EpidemicCode.org}},
}
```

## License

**EPIDEMIC** is released under the MIT license. See the LICENSE file for details. All new contributions must be made under the MIT license.

## Funding

<img src="logo/faperj.jpg" width="20%"> &nbsp; &nbsp; <img src="logo/cnpq.png" width="20%"> &nbsp; &nbsp; <img src="logo/capes.png" width="10%">

## Institutional support

<img src="logo/uerj_logo_cor.jpg" width="13%"> &nbsp; &nbsp; <img src="logo/ufrj_logo_cor.png" width="10%"> &nbsp; &nbsp; <img src="logo/ufu_logo_cor.png" width="12%"> &nbsp; &nbsp; <img src="logo/ifms_logo_cor.png" width="15%"> &nbsp; &nbsp; <img src="logo/unesp_logo_cor.png" width="20%">

## Contact

Contributions to the software, reports problems or support can be done via email americo.cunha@uerj.br
