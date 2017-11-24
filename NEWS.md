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
