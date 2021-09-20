## Resubmission

Dependency on external data has been revised to comply with CRAN policy: 
- demo data are now delivered with the package, to enable offline package testing, examples and vignette building; also more detailled documentation on these data was added. 
- calls on external resources for research purposes now fail with an informative message without causing errors or warnings when the resource is not available 

## Test environments

* Windows 10, R version 4.1.1 on local install (2021-09-20) 
* Windows 10, R version 4.1.1 on local install without internet connectivity (2021-09-20) 
* Mac OS X 10.15.7, R version  4.1.1 (2021-08-10) on GitHub Actions  (2021-09-18)
* Microsoft Windows Server 2019 10.0.17763, R version  4.1.1 (2021-08-10) on GitHub Actions  (2021-09-20) 
* Ubuntu 20.04.3 LTS, R version 4.1.1 (2021-08-10), R oldrel 4.0.5 (2021-03-31) and R devel (2021-09-18 r80932) on GitHub Actions  (2021-09-20)
* Windows Server 2008  (64-bit), R devel (2021-09-17 r80929) on win-builder.r-project.org  (2021-09-20) 

## R CMD check results

There were no ERRORs or WARNINGs or NOTES. 

## Downstream dependencies

There are no downstream dependencies for this package yet. 
