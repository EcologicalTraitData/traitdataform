#' Standardize scientific names of species
#' 
#' @description Adds columns to a traitdata object containing accepted species 
#'   names and relates to globally unique taxon identifiers via URI.
#'   
#' @param x a traitdata object (as returned by `as.traitdata()`) or a data table
#'   containing at least the column `scientificName.
#' @param method not functional. Will allow to chose from different sources of 
#'   taxonomic reference.
#' @param update if TRUE, force update of taxonomy, even if attributes already
#'   contain one. defaults to FALSE.
#' @param infraspecies not functional.
#' @param fuzzy if set to `FALSE` (default mode), this disables fuzzy matching 
#'   if problems with ambiguous species names arise.
#' @param verbose has currently no effect.
#' @param return a character vector containing the informatoin that should be 
#'   extracted into the output. Valid entries are the column names returned by 
#'   function `get_gbif_taxonomy()`. See 'Details'.
#'   
#' @details Taxonomic standardisation is an enormous challenge for biodiversity 
#'   data management and research. Constant changes in species and higher taxa, 
#'   refinements of phylogenetic trees and changing attribution to original 
#'   authors, moving species into other genera or difficulties to place species 
#'   into the Linean nomenclature results in highly fluctuent taxonomic 
#'   definitions.
#'   
#'   As a consequence, there is not one reference for accepted species names and
#'   dependin on the field of resaerch and taxonomic focus other authorities 
#'   will be employed.
#'   
#'   For reasons of simplicity and because of its high coverage of taxa, the 
#'   function `standardize.taxonomy()` uses the GBIF Backbone Taxonomy as its 
#'   reference system and resolves all provided species names to the accepted 
#'   name according to GBIF (resolving misspellings and synonyms in the 
#'   process). We invite pull requests to make this function more general and 
#'   enable a choice of a taxonomic reference.
#'   
#' @export
#' 
#' 
#' @examples 
#' 
#' 
#' data(carabids)
#' 
#' dataset1 <- as.traitdata(carabids, 
#'   taxa = "name_correct", 
#'   traits = c("body_length", "antenna_length", "metafemur_length"),
#'   units = "mm",
#'   keep = c(datasetID = "source_measurement", measurementRemark = "note"), 
#'   metadata = list(
#'     bibliographicCitation = attributes(carabids)$citeAs,
#'     author = "Fons van der Plas", 
#'     license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'     )
#' )
#' 
#' dataset1Std <- standardize.taxonomy(dataset1)
#' 
#' #update to include more taxon detail
#' 
#' dataset1Std <- standardize.taxonomy(dataset1Std, return = c("author", "genus", "order", "class"))
#' 
standardize.taxonomy <- function(x, 
                                 method = get_gbif_taxonomy,
                                 update = FALSE, 
                                 infraspecies = FALSE, 
                                 fuzzy = FALSE, 
                                 verbose = TRUE, 
                                 return = c("taxonID", 
                                            "scientificNameStd", 
                                            "order", 
                                            "taxonRank"), 
                                 ...) {

  #if(!"traitdata" %in% class(x)) mapping(x, ...)
  
  # check 
  if(!is.null(attributes(x)$taxonomy) && "taxonomy" %in% class(attributes(x)$taxonomy) && !update) { 
    temp <-  attributes(x)$taxonomy    
    # eliminate columns that will be replaced
    x <- x[,!colnames(x) %in% c(return, "taxonID", "scientificNameStd")]
  } else {
    temp <- method(levels(droplevels(x$scientificName)), infraspecies = infraspecies, fuzzy = fuzzy, verbose = verbose)
  } 
  
  class(temp) <- c("taxonomy", "data.frame")
  
  out <- merge.data.frame(x, temp[, unique(c(return, "taxonID", "scientificNameStd", "scientificName", "warnings"))], by.x = "scientificName", by.y = "scientificName")
  
  #TODO: produce warning for unmatched names!
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  # keep attributes of x
  attribs <- attributes(x)
  attribs$names <- attributes(out)$names
  attributes(out) <- attribs
  
  attr(out, "taxonomy") <- temp
  
  return(out)
}


#' Standardize trait names and harmonize measured values and reported facts
#' 
#' @description Adds columns to a traitdata table with standardized trait names 
#'   and relates them to globally unique identifiers via URIs. Optionally 
#'   converts units of values and renames factor levels into accepted terms.
#'   
#' @param x a traitdata object (as returned by `as.traitdata()`) or a data table
#'   containing at least the columns `traitValue`.
#' @param thesaurus an object of class 'thesaurus' (as returned by 
#'   `as.thesaurus()`).
#' @param rename character vector of same length and order as 
#'   `levels(x$traitName)`. Will superimpose names of traits to match thesaurus 
#'   input names. (see Details)
#' @param output a switch to set the desired output format. Defaults to 
#'   "logical", but can be "character", "binary" or "factor".
#' @param categories output target categories for binary/logical traits 
#'   harmonization if `output` is not set to 'logical'.
#'   
#' @import units
#' @return Adds harmonized columns to the traitdata object, including
#'   
#'   - unit conversion 
#'   - factor level harmonization 
#'   - global or dataset-specific identifier for trait definitions
#'   
#'   The lookup table of trait definitions (Thesaurus) is attached to the output
#'   object as an attribute and can be accessed by calling
#'   `attributes(<output>)$thesaurus`.
#'   
#' @export
#' 
#' @examples 
#' 
#' data(carabids)
#' 
#' dataset1 <- as.traitdata(carabids, 
#'   taxa = "name_correct", 
#'   traits = c("body_length", "antenna_length", "metafemur_length"),
#'   units = "mm",
#'   keep = c(datasetID = "source_measurement", measurementRemark = "note"), 
#'   metadata = list(
#'     bibliographicCitation = attributes(carabids)$citeAs,
#'     author = "Fons van der Plas", 
#'     license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'     )
#' )
#' 
#' traitlist <- as.thesaurus(
#' body_length = as.trait("body_length", expectedUnit = "mm", valueType = "numeric",
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"), 
#' antenna_length = as.trait("antenna_length", expectedUnit = "mm", valueType = "numeric",
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Antenna_length"),
#' metafemur_length = as.trait("metafemur_length", expectedUnit = "mm", valueType = "numeric",
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
#' )
#' 
#' dataset1Std <- standardize.traits(dataset1, thesaurus = traitlist)
#' 
standardize.traits <- function(x,
                               thesaurus, 
                               rename = NULL,
                               categories = c("No", "Yes"), 
                               output = "logical",
                               ...
                               ) {
  
  x$traitNameStd <- x$traitName
  
  # perform renaming of traits
  if(is.null(rename) && length(thesaurus) == length(levels(x$traitName)) && !is.null(names(thesaurus))) { 
    levels(x$traitNameStd) <- names(thesaurus)
  }
  
  # perform renaming following named vector
  if(is.null(names(thesaurus)) && !is.null(names(rename))) {
    levels(x$traitNameStd) <- traitmap[match(levels(x$traitName), names(rename) )]
  }
  
 lookup <- do.call(rbind, lapply(thesaurus,data.frame))
 
 if(is.null(levels(lookup$identifier))) lookup$identifier <- as.factor(seq_along(lookup$trait))
 
 lookup <- cbind(traitNameStd = names(thesaurus), lookup)
 
 out <- merge(x, lookup[,c("trait","identifier" )], by.x = "traitNameStd", by.y = "trait", sort = FALSE )
 
 ## rename columns according to ETS
 colnames(out)[colnames(out) == "trait"] <- "traitNameStd"
 
 ## generate standardized trait vector
 
 out$traitValueStd <- NA

 # add column for standardised Unit and preserve factor levels
 out$traitUnitStd <- factor(NA, levels = levels(lookup$expectedUnit))
 
 #templist <- split(temp, f = temp$traitNameStd) 
 
 traits <- levels(out$traitNameStd) #levels(lookup$trait) #
 
 for(i in 1:length(traits)) { # iterate over all trait categories (by user provided names)
   
   # harmonize logical values
   if(is.na(lookup[i,]$valueType) ) {warning("trait value has not been harmonized to standard terms! To perform standardization provide field 'valueType', as well as 'traitUnitStd' and 'factorLevels' for numeric and factorial traits, respectively!")} else {
     
     # harmonize logical/binary/boolean trait variables
     if(lookup[i,]$valueType == "logical") {
       templist <- split(out, f = out$traitNameStd) 
       out[out$traitName == traits[i],"traitValueStd"] <- fixlogical(
           templist[[i]]$traitValue, output = output, categories = categories
           )
     }
     
     ## factor level harmonization 
     
     #NOT WORKING !!!
     
     if(lookup[i,]$valueType == "categorical") { 
       subset(out, traitName == traits[i])$traitValueStd 
       
     } ## end of factor level harmonization
     
     ## unit conversion:
     if(lookup[i,]$valueType == "numeric") {
       
       out$traitUnitStd[out$traitName == traits[1]] <- lookup$expectedUnit[i]
       
       unit_original <- droplevels(subset(out, traitName == traits[i])$traitUnit)
       unit_target <- droplevels(subset(out, traitName == traits[i])$traitUnitStd)
       
       # case 1: homogeneous units for the entire trait
       if(length(levels(unit_original)) == 1 && length(levels(unit_target)) == 1) {
         
         value_original <-  subset(out, traitName == traits[i])$traitValue * units::ud_units[[levels(unit_original)]]
         out[out$traitName == traits[i], "traitValueStd"] <- units::set_units(value_original, units::parse_unit(levels(unit_target)))
         
       } else {     # case 2: heterogeneous units used within a single trait
         
         value_original <-  subset(out, traitName == traits[i])$traitValue
         for(j in seq_along(value_original))  {
           
           value_original_j <- value_original[j] * units::ud_units[[as.character(unit_original[j])]] 
           out[out$traitName == traits[i],"traitValueStd"][j] <- units::set_units(value_original_j , units::parse_unit(as.character(unit_target[j]))) 
         }
         
       }
       
     } ## end of unit conversion
     
   }
   
 }
 
 # sort columns according to glossary of terms
 out <- out[, order(match(names(out), glossary$columnName) )]
 
 # keep attributes of x
 attribs <- attributes(x)
 attribs$names <- attributes(out)$names
 attributes(out) <- attribs
 attr(out, "thesaurus") <- as.thesaurus(lookup)
 
 return(out)
}


#' Standardize trait datasets
#' 
#' @description wrapper that applies `standardize.taxonomy()` and
#'   `standardize.traits()` in one go.
#' 
#' @param x
#' @param ... 
#' @inheritParams standardize.traits 
#' @inheritParams standardize.taxonomy
#' @export
#' 
standardize <- function(x,
                        ..., 
                        verbose = NULL,
                        warnings = NULL) {
  
                          if("data.frame" %in% class(x) && ! "traitdata" %in% class(x) ) x <- as.traitdata(x,...)
                          x <- standardize.taxonomy(x, ...)
                          x <- standardize.traits(x, ...)
                      }
