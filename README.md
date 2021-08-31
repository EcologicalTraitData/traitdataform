# Package 'traitdataform': Formatting and Harmonizing Ecological Trait-Data 

[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) 
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN status](https://www.r-pkg.org/badges/version/traitdataform)](https://cran.r-project.org/package=traitdataform)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1489527.svg)](https://doi.org/10.5281/zenodo.1489527)


Assistance for handling functional trait data and transferring them into the Ecological Trait-Data Standard (Schneider et al. 2019 Towards an Ecological Trait-data Standard, *Methods in Ecology and Evolution* DOI: [10.1111/2041-210X.13288]( https://doi.org/10.1111/2041-210X.13288)). 

There are two major use cases for the package: 

- preparation of own trait datasets for upload into public data bases, and
- harmonizing trait datasets from different sources by moulding them into a unified format.

The toolset of the package includes

- transforming species-trait-matrix or occurrence table data into a unified long-table format
- mapping column names into terms provided in a standard trait vocabulary
- matching of species names into GBIF Backbone Taxonomy (taxonomic ontology server)
- matching of trait names into a user-provided trait list, i.e. a thesaurus of traits
- unifying trait values into target unit format and legit factor levels
- saving trait dataset into a desired format using templates (e.g. for BExIS)

## Installation

Install from CRAN via

```r
install.packages('traitdataform')
```

The development version of the package can be installed from Github via the 'devtools' package

```r
install.packages('devtools')
devtools::install_github('EcologicalTraitData/traitdataform')
```
## System requirements 

The package requires the [udunits library](https://www.unidata.ucar.edu/software/udunits/) for unit conversion to be installed. It should install automatically, but if the package installation throws an error, it might need manual installation (see [this thread for help](https://github.com/r-quantities/units/issues/1)).  

## Usage

```r

pulldata("carabids")

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

If you want  further data sources published under Creative Commons Licenses or in the public domain being added to this package, feel free to file a pull-request with a script for download and harmonization in the `data/` directory and a documentation appended to `R/data.R`! 


## Contributing

The package invites any contributions e.g. minor fixes and spell-checks, improving interoperability with data and other packages or software for trait-data handling. Please see [the Contributing Guidelines](https://ecologicaltraitdata.github.io/traitdataform/CONTRIBUTING.html) for details.

Please note that the 'traitdataform' project is released with a [Contributor Code of Conduct](https://ecologicaltraitdata.github.io/traitdataform/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.

## Future features

The package is under open source development. You are invited to submit pull-requests with your improvements. 

We are aiming to provide the following features in future iterations of the package: 

- extracting trait definitions and hierarchies from semantic ontologies (e.g. from the OWL files or via APIs), to facilitate analysis of comparable traits across taxa. 
- automated matching of user-provided trait names against trait definitions in online resources, by looking up traits from published ontologies.
- harmonization of levels of factorial traits via fuzzy matching (requires lookup tables and ontologies providing legit factor levels). 
- managing trait databases locally in R by managing relational data (e.g. on occurrence level or measurement level, sampling event,  taxon etc.) in the data.frame attributes. 

## Cite as

Schneider, F.D. (2021) traitdataform - harmonizing ecological trait data in R, v0.6.5, DOI: [10.5281/zenodo.1489527](http://dx.doi.org/10.5281/zenodo.1489527) http://ecologicaltraitdata.github.io/traitdataform

## License

Copyright (c) 2021 F.D. Schneider, florian.dirk.schneider@gmail.com

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
