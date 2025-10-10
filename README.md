
# S-typeridge.reg: An R package for the S-type ridge regression
This R package implements S-type ridge regression: a robust and multicollinearity-aware linear regression estimator that combines S-type robust weighting with ridge penalization. The method targets two common hurdles in linear modeling simultaneously: sensitivity to outliers and inflated variance due to severe multicollinearity.
The S-type estimators were introduced by Sazak and Mutlu (2023) in “Comparison of the Robust Methods in the General Linear Regression Model.” The ridge parameter k is selected automatically via the approach implemented in the `ridgregextra` R package (Karadağ et al., 2023;  Karadağ and Sazak, 2022), which targets VIF values close to but not below 1 (following Kutner et al., 2004). For automatic ridge parameter selection, the package leverages the approach operationalized in the `ridgregextra` package, so users do not need to tune k manually.
This package, in conjunction with the `Stype.est` package, offers a robust ridge regression solution adept at addressing issues of extreme multicollinearity and outliers, providing S-type ridge estimates without requiring manual adjustment of the ridge parameter.
There are two functions in this package:  

●        `Weightedridge.reg` (sub-function): Given a data set and a user-supplied weight vector w, it returns the weighted ridge regression results (coefficients, fitted values, residuals, standard errors, and related diagnostics).

●        `regstyperidge` (main function): Given x and y, it automatically determines the ridge parameter and returns the S-type ridge regression results end-to-end.

## Features
●       Robust ridge regression using S-type estimators (downweights outliers while stabilizing estimates under high collinearity).
●       Automatic ridge parameter selection (no manual tuning required).
●       Comprehensive outputs: coefficients, fitted values, residuals, model MSE, coefficient standard errors etc.
●       Works with user-provided weights via Weightedridge.reg for advanced use cases.
●       Simple main entry point (`regstyperidge`) with familiar x/y interface.
 
# Installation
To install the package from GitHub, use the following command:
 
# Installing `S-typeridge.reg` development version
Please make sure that you installed `devtools` package first:
```
install.packages("devtools")
```
 
# Install the package
```
devtools::install_github("filizkrgd/S-typeridge.reg")
```
# Installing `S-typeridge.reg` from CRAN
```
install.packages( “S-typeridge.reg”)
```
Installing `S-typeridge.reg` development version
 
# Example usage of the package.
When you install `S-typeridge.reg`, required packages such as `ridgregextra` and  `Stype.est` will be installed automatically via dependencies. For example data, you can install and load the `isdals` package (it contains the bodyfat data set). The base `isdals` package comes with R.
- Prepare an example data set (bodyfat) from isdals:
```
library(isdals)
data(bodyfat)
x=bodyfat[,-1]
y=bodyfat[,1]
 ```
- Run `regstyperidge` function to get ridge regression results using the S-type ridge regression estimators.
```
regstyperidge=regstyperidge(x,y)
regstyperidge$MSE
regstyperidge$stdbeta
```
- Run Weightedridge.reg to fit weighted ridge regression with S-type estimators using x, y, and W (weights); returns coefficients, fitted values, residuals, standard errors, and diagnostics.
```
weightedridgereg=Weightedridge.reg(x,y,W)
weightedridgereg$MSE
weightedridgereg$stdbeta
```
 ## References
- Karadağ, F. and Sazak, H.S., “R Algorithm for Ridge Parameter Estimation in Ridge Regression” Why R? Turkey 2022 Conference, online, Verbal, Summary Text, p.13, 2022. (https://www.nobelyayin.com/why-r-turkiye-2022-konferansi-18447.html)
- Karadağ, F., Sazak, H. S., and Aydın, O. (2023). ridgregextra: Ridge Regression Parameter Estimation. R package version 0.1.1. Available at CRAN. URL: https://CRAN.R-project.org/package=ridgregextra
- Kutner, M. H., Nachtsheim, C. J., Neter, J., and Li, W. (2004). Applied Linear Statistical Models
- Sazak, H. S., Karadağ, F., and Aydın, O. (2025). Stype.est: S-Type Estimators. R package version 0.1.0. URL: https://cran.r-project.org/web/packages/Stype.est/Stype.est.pdf
- Sazak, M. and Mutlu, B. (2023). Comparison of the Robust Methods in the General Linear Regression Model.
 
## Contact
For any questions please contact:
 
- Filiz Karadag, filiz.karadag@ege.edu.tr
- Hakan Savas Sazak, hakan.savas.sazak@ege.edu.tr
- Olgun Aydin, olgun.aydin@pg.edu.pl
 


