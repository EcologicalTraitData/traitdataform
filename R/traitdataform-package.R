#' Package 'traitdataform': harmonizing ecological trait data in R
#'
#' This package assists in handling functional trait data and transferring them
#' into the Trait Data Standard (Schneider et al. in preparation).
#'
#' There are two major use cases for the package:
#'
#' - preparation of own trait datasets for upload into public data bases, and 
#' - harmonizing trait datasets from different sources by moulding them into a
#' unified format.
#'
#' The toolset of the package includes
#'
#' - transforming species-trait-matrix or observation table data into a unified
#' long-table format 
#' - mapping column names into terms provided in a standard trait vocabulary 
#' - matching of species names into GBIF Backbone Taxonomy (taxonomic ontology 
#' server) 
#' - matching of trait names into a user-provided traitlist, i.e. a thesaurus 
#' of traits 
#' - unifying trait values into target unit format and legit factor levels 
#' - saving trait dataset into a desired format using templates (e.g. for BExIS)
#' 
#' 
#' A documentation is available online at
#' http://ecologicaltraitdata.github.io/traitdataform/ or offline in the package
#' vignette 'traitdataform'.
#' 
#' @keywords internal
#' @name traitdataform-package
NULL
