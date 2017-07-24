# traitdataform

This package assists in handling functional trait data and transferring them into the trait data standard (Schneider et al). 

There are two major use cases for the package: 

- preparation of own trait datasets for upload into public data bases, and
- harmonizing trait datasets from different sources by moulding them into a unified format.

The toolset of the package includes

- transforming species-trait-matrix or occurence table data into a unified format
- mapping column names into terms provided in the trait data standard
- matching of species names into GBIF Backbone Taxonomy (taxonomic ontology server)
- matching of trait names into a user-provided traitlist, i.e. a thesaurus of traits
- unifying trait values into target unit format and legit factor levels
- saving trait dataset into a desired format using templates (e.g. for BExIS)

## Install

The package can be installed from Github via the 'devtools' package

```r
install.packages('devtools')
devtools::install_github('fdschneider/traitdataform')
```

## minimal example

```r
thesaurus <- as.thesaurus(body_length = as.trait("body_length", 
                                                 traitUnit = "mm", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric"),
                          antenna_length = as.trait("antenna_length", 
                                                 traitUnit = "mm", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric"),
                          metafemur_length = as.trait("metafemur_length", 
                                                 traitUnit = "mm", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric"),
                          eyewidth = as.trait("eyewidth_corr", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric")
            ) 
                          
traitdataset1 <- standardize(carabids,
            thesaurus = thesaurus,
            taxa = "name_correct",
            units = "mm",
            keep = c(measurementDeterminedBy = "source_measurement")
            )

```

## datasets

The traitdataform package links to a couple of public domain datasets, which are used for demo purposes, but can be used for research and production use.  

- `passerines` by Ricklefs 2017
- `arthropodtraits` by Gossner, Simons et al. 2016
- `heteropteraRaw` & `heteroptera` by Gossner, Simons et al. 
- `carabids` by van der Plas et al. 2017

The datasets have been published by their authors under [Creative Commons 0](https://creativecommons.org/publicdomain/zero/1.0/) license, which means they can be copied, modified, distributed without asking permission. For additional information and interpretation of the data please refer to the help pages of the data objects (e.g. calling `?passerines` in R) and the original data sources given therein. 

If you want  further datasources published under CC0 or in the public domain being added to this package, feel free to file a pull-request with an updated  `R/data.R`! 

## cite as

...


## License

Copyright (c) 2017 F.D. Schneider, fd.schneider@senckenberg.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
