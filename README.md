# Package 'traitdataform' - harmonizing ecological trait data in R

This package assists in handling functional trait data and transferring them into the Trait Data Standard (Schneider et al. in preparation). 

There are two major use cases for the package: 

- preparation of own trait datasets for upload into public data bases, and
- harmonizing trait datasets from different sources by moulding them into a unified format.

The toolset of the package includes

- transforming species-trait-matrix or occurence table data into a unified long-table format
- mapping column names into terms provided in the trait data standard (Schneider et al. 2017)
- matching of species names into GBIF Backbone Taxonomy (taxonomic ontology server)
- matching of trait names into a user-provided traitlist, i.e. a thesaurus of traits
- unifying trait values into target unit format and legit factor levels
- saving trait dataset into a desired format using templates (e.g. for BExIS)

## Installation

The package can be installed from Github via the 'devtools' package

```r
install.packages('devtools')
devtools::install_github('fdschneider/traitdataform')
```

## Usage

```r

data(carabids)

thesaurus <- as.thesaurus(
       body_length = as.trait("body_length", 
         expectedUnit = "mm", 
         identifier = "length"
         ), 
       antenna_length = as.trait("antenna_length", 
         expectedUnit = "mm", 
         identifier = "antenna"
         ),
       metafemur_length = as.trait("metafemur_length", 
         expectedUnit = "mm", 
         identifier = "metafemur"
         ),
       eyewidth = as.trait("eyewidth_corr", 
         expectedUnit = "mm", 
         identifier = "eyewidth"
         )
)
                          
traitdataset1 <- standardize(carabids,
            thesaurus = thesaurus,
            taxa = "name_correct",
            units = "mm"
            )

```
## Documentation

A documentation is available online at http://ecologicaltraitdata.github.io/traitdataform/ or offline in the package vignette 'traitdataform'. 

## Datasets

The traitdataform package links to a couple of datasets, which are used for demo purposes in the vignette and documentation, but can be used for research and production use.  

The datasets have been published by their authors under [Creative Commons 0](https://creativecommons.org/publicdomain/zero/1.0/) or [Creative Commons Attribution](https://creativecommons.org/licenses/by/4.0/) license, which means they can be copied, modified, distributed without asking permission. Attribution must be given according to the dataset license.  

For additional information and interpretation of the data please refer to the help pages of the data objects (e.g. calling `?carabids` in R) and the original data sources given therein. 

If you want  further datasources published under Creative Commons Licenses or in the public domain being added to this package, feel free to file a pull-request with a script for download and harmonization in the `data/` directory and a documentation appended to `R/data.R`! 

## Future features

The package is under open source development. You are invited to submit pull-requests with your improvements. 

We are aiming to provide the following features in future iterations of the package: 

- extracting trait definitions and hierarchies from semantic ontologies (e.g. from the OWL files or via APIs), to facilitate analysis of comparable traits across taxa. 
- automated matching of user-provided trait names against trait definitions in online resources, by looking up traits from published ontologies.
- harmonization of levels of factorial traits via fuzzy matching (requires lookup tables and ontologies providing legit factor levels). 
- managing trait databases locally in R by turning the traitdataset objects into lists containing additional linked data (e.g. on occurence level or measurement level, sampling event,  taxon etc.). 
- saving trait datasets as Darwin Core Archives. 

## Cite as

Schneider, F.D. (2017) traitdataform - harmonizing ecological trait data in R, v0.2, doi: xxx.xxx, http://ecologicaltraitdata.github.io/traitdataform

## License

Copyright (c) 2017 F.D. Schneider, florian.dirk.schneider@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
