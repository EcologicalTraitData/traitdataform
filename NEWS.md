# traitdataform 0.5 (released 04.12.2018)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1921175.svg)](https://doi.org/10.5281/zenodo.1921175)

stable, for submission on CRAN. From this point on, backwards compatibility will be maintained. 

minor changes (since v0.4): 

- complete package vignette 
- improved unit handling
- solid demo data import

---

# traitdataform 0.4.4

- finalize vignette (include section on writing data)

# traitdataform 0.4.3

- update rbind.traitdataform() to specify metadata handling

# traitdataform 0.4.2

- finalize package vignette
- simplify demo data calls
- fix handling of measurementID as factor
- fix return of output in standardize()

# traitdataform 0.4.1

- update package vignette
- fix print methods
- fix thesaurus function
- set helper functions internal (not exported) 
- fix file import for carabids

# traitdataform 0.4.0 (released 26.11.2018)

## bugfixes

- fix locale issues with pulldata() on linux (still not solved on Mac OS X)
- eliminate dependency on 'reshape' package

## Minor changes

- the functions cast.traitdata() and mutate.traitdata() now support units. 

# traitdataform 0.3.4

- update as.trait() and as.thesaurus() as well as print methods
- update dependencies on units()

# traitdataform 0.3.3

- rename and update standardize_taxa() <- standardize.taxonomy()
- rename standardize_traits() <- standardize.traits()
- fix environment issues with pulldata()

# traitdataform 0.3.1

- clean rewrite of get_gbif_taxonomy()
- test_that implementation
- Travis CI implementation 
- add Code of Conduct and CONTRIBUTING

# traitdataform 0.3.0

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1489528.svg)](https://doi.org/10.5281/zenodo.1489528)

- solve all errors, warnings and notes on R CHECK
- complete man pages  
- fix matching bug for get_gbif_taxonomy()

---

# traitdataform 0.2.6 

- fix function mutate.traitdata() (remove method dependency to dplyr)
- update documentation for as.trait()
- successful build of vignette

# traitdataform 0.2.5

- fix export of get_gbif_taxonomy() 
- handle subspecies and superspecies cases
- handle warnings in taxon mapping output
- update documentation on taxon mapping

# traitdataform 0.2.4

- fix export of `standardize.exploratories()` to include all columns by default. 
- start fixing install warnings 

# traitdataform 0.2.3

- fixing broken NAMESPACE export
- update documentation website

# traitdataform 0.2.2

- fix bug in `standardize.taxonomy()`: reset row.names. 
- update data attributes in dataset `carabids` for handling in `as.traitdata()`.

# traitdataform 0.2.1

- add function `as.metadata()` for templating of metadata into an object class, including method `print.metadata()`
- update as.traitdata, print.traitdata, rbind.traitdata to make use of `as.metadata` 
- provide metadata and thesaurus as attributes in data object 'carabids'
- update `as.traitdata()`: enable forwarding of attributes of input object (for metadata etc. )

# traitdataform 0.2

## Major changes

- updated terms to traitdata standard v0.6.
- datasets are not loaded by default, but wait for a prompt using `data()`. Also added documentation for all datasets and added more datasets.  
- adding function method `rbind.traitdata()` for merging standardised datasets into a unified table. includes handling of metadata object in attributes
- metadata can be stored in the attributes of a dataset and will be preserved when updating the dataset. Information will be handled when merging or combining multiple datasets. 
- trait thesauri can be added more easily from a data frame or from a list of 'trait' objects. 


## Minor changes

- update vignette: add section on merging and combining data. 
- added print methods for traits and thesaurus objects. 


# traitdataform 0.1.7

## Major changes

- add function `standardize.exploratories()` to extract georeference data for a plotID. 
- add function `read.service()` (provided by Dennis Heimann & Andreas Ostrowski)  for access of datasets on BExIS. I added a secure masked prompt using the 'getPass' package. 

## Bug fixes

- Spelling of 'occurrence' 
