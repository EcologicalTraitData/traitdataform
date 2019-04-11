## Resubmission

This is a minor fix prompted by request of Prof. Ripley ("failing checks in a strict Latin-1 locale"). 

* character issues in strict Latin-1 locale have been resolved (apostrophe and en-dash)
* a dependency on an external resource (ETS.csv) is now static.

## Test environments

* local Windows 10 install, R version 3.5.1 (2019-04-11) 
* Windows R devel on win-builder.r-project.org, platform: x86_64-w64-mingw32 (64-bit), R version 3.5.3 (2019-04-11)
* local Mac OS X 10.13.6, R version 3.5.3 (2019-04-11)
* Ubuntu 14.04.5 LTS (on travis-ci), R version 3.5.3 (2019-04-11) and R devel (2019-04-11)

## R CMD check results

There were no ERRORs or WARNINGs or NOTES. 

## Downstream dependencies

There are no downstream dependencies for this package yet. 
