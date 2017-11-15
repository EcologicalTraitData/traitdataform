# traitdataform 0.2

## Major changes

- updated terms to traitdata standard v0.6.
- datasets are not loaded by default, but wait for a prompt using `data()`. Also added documentation for all datasets and added more datasets.  
- adding function method `rbind.traitdata()` for merging standardised datasets into a unified table. 
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
