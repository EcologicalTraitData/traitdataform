## Resubmission

The package version v0.5.3 has been archived on 2019-05-02-26 as check issues were not corrected in time.
This is a fix of the package to enable it to build in a strict Latin-1 locale (CRAN check flavor r-devel-linux-x86_64-debian-clang). 

* UTF-8 encoding is forced before pulling a non-latin1-compatible data source (in vignette and inst/data)
* tests for successful encoding are now conditionally run

## Test environments

* local Windows 10 install, R version 3.6.0 (2019-05-06) 
* Windows R devel on win-builder.r-project.org, platform: x86_64-w64-mingw32 (64-bit), R version 3.6.0 (2019-05-06)
* local Mac OS X 10.13.6, R version 3.6.0 (2019-05-06)
* Ubuntu 14.04.5 LTS (on travis-ci), R version 3.6.0 (2019-05-06) and R devel (2019-05-06)
* Debian Linux, clang, ISO-8859-15 locale (on R-hub), R devel (2019-05-06)

## R CMD check results

There were no ERRORs or WARNINGs or NOTES. 

## Downstream dependencies

There are no downstream dependencies for this package yet. 
