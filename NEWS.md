# traitdataform 0.1.8

## Major changes

- datasets are not loaded by default, but wait for a prompt using `data()`. Also added documentation for all datasets and added more datasets.  
- adding function method `rbind.traitdata()` for merging standardised datasets into a unified table. 

## Minor changes

- update vignette: add section on merging and combining data. 


# traitdataform 0.1.7

## Major changes

- add function `standardize.exploratories()` to extract georeference data for a plotID. 
- add function `read.service()` (provided by Dennis Heimann & Andreas Ostrowski)  for access of datasets on BExIS. I added a secure masked prompt using the 'getPass' package. 

## Bug fixes

- Spelling of 'occurrence' 
