# traitdataform 0.6.5

- update Rd documentation pages to include return value

# traitdataform 0.6.4

- fix tidyverse URL in README

# traitdataform 0.6.3

- fix: reference to doi in Rd documentation syntax

# traitdataform 0.6.2

- update call to package `units` (pull request #42 by Iñaki Ucar)
- update new taxon names in tests 

# traitdataform 0.6.1

- fix to comply to CRAN policy: Packages which use Internet resources should fail gracefully with an informative message if the resource is not available or has changed (and not give a check warning nor error). 


# traitdataform 0.6.0

Major changes: 

- update internal terms to v0.10 of the Ecological Trait-data Standard (ETS). 
  In ETS v0.10 the assignment of user-defined and standardised measurement values and trait and taxon assignments has been updated, to match labelling practice in DwC and provide a more intuitive content for those fields. Accordingly
    - the v0.9.1 terms `scientificName`, `traitName`, `traitValue`, and `traitUnit` have been renamed into `verbatimScientificName`, `verbatimTraitName`, `verbatimTraitValue`, and `verbatimTraitUnit` with new identifiers. 
    - the terms `scientificNameStd`, `traitNameStd`, `traitValueStd`, and  `traitUnitStd` have been renamed into `scientificName`, `traitName`, `traitValue`, and `traitUnit` and now form the default suggested content for trait data complying with the ETS. Definitions have been harmonized. The original *Std identifiers now resolve to these new terms.

  This causes the output file to differ from earlier outputs. To maintain compatibility with earlier versions, an option `conformsTo` has been added to `as.traitdata()` to return the data table in terms of version 0.9. By default, output is returned in ETS version 0.10.  Data releases created by `traitdataform` should always be labelled with the version of ETS that applies to the data! 
  

# traitdataform 0.5.7

- Preparing for R 4.0.0 change to read.table() and data.frame(): handling of factor data (trait and taxon names) is now locale-independent
- updating download links for Data Dryad 

# traitdataform 0.5.6

- fix broken data calls to datadryad.org

# traitdataform 0.5.5

- upgrading vignette to knitr v1.23 upon request of CRAN

# traitdataform 0.5.4

- enforce UTF-8 environment in Latin-1 locale now works for 

# traitdataform 0.5.3 (released on CRAN	2019-04-16)

- character issues in strict Latin-1 locale have been resolved (apostrophe and en-dash)
- a dependency on an external resource (ETS.csv) is now static.

# traitdataform 0.5.2 (released on CRAN 30.12.2018)

- solve minor compliance issues with CRAN: use LICENSE template

# traitdataform 0.5.1

- thorough spell-checking 
- set heavy examples to 'dontrun'

# traitdataform 0.5.0 (released 04.12.2018)

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
