<img src="docs/logo/EPIDEMIC_Logo.png" width="50%">

**EPIDEMIC - Epidemiology Educational Code** is an easy to run educational Matlab toolkit for epidemiological analysis, which offers functionalities for modeling an epidemic, monitoring its progress and forecasting the underling numbers of interest. This code is, first of all, an educational tool for researchers and students who are interested in computational epidemiology. The programs and tutorials are designed to offer good introductory material for beginners in the field. But they can also be used to analyze epidemic data, as well as in the construction of some simplistic epidemic models. The package is structured in 3 independent modules:
- **Modeling:** which uses differential equation-based compartmental models to emulate the dynamic behavior of homogeneous populations during an epidemic scenario;
- **Trends:** which uses several types of trend graphs to analyze the dynamic behavior of an epidemic as well as its underlyng rate of progress;
- **Forecast:** which uses data-driven statistical regressors to make short-term predictions about certain quantities of interest underlying the epidemic.


This package includes the following file:

**MODELING:**

SIR
- main_SIR.m
- rhs_SIR.m 

SEIR
- main_SEIR.m
- rhs_SEIR.m 

SEIRD
- main_SEIRD.m
- rhs_SEIRD.m 

SEIAHRD
- main_SEIAHRD.m
- rhs_SEIAHRD.m 

**TRENDS:**
- epidemic_trends.m

**FORECAST:**
- epidemic_forecast.m


## Support

Full user guides for **EPIDEMIC** packages are provided in the doc directory along with documentation for example programs.

## Team:

- Adriano Cortês
- Amanda Cunha Guyt
- Americo Cunha
- Bruna Pavlack
- Diego Matos
- Eber Dantas
- João Pedro Norenberg
- Julio Basilio
- Karla Figueiredo
- Leonardo de la Roca
- Lisandro Lovisolo
- Lucas Chaves
- Marcos Vinicius Issa
- Malú Grave
- Michel Tosin
- Rodrigo Burgos
- Roberto Luo
- Roberto Velho

## Citing EPIDEMIC:

We ask users to cite the following manual in any publications reporting work done with **EPIDEMIC**:

Americo Cunha Jr, et al. XXXX

## License

**EPIDEMIC** is released under the MIT license. See the LICENSE file for details. All new contributions must be made under the MIT license.
