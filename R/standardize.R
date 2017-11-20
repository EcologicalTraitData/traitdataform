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
#'   containing at least the column `scientificName.
#' @param thesaurus an object of class 'thesaurus' (as returned by
#'   `as.thesaurus()`).
#' @param rename a named vector to map user-provided names to thesaurus object
#'   names (see Details).
#' @param categories target categories for binary/logical traits harmonization.
#' @param output
#'   
#' @import units
#' @export
#' 
#' @details The function matches the trait names provided in 'traitName' to the
#'   traits provided in the thesaurus (in field 'trait'). Matching must be exact
#'   (case sensitive). Fuzzy matching may be provided in a later version of the
#'   package.
#'   
#'   The function parameter 'rename' should be provided to map trait names where
#'   user-provided names and thesaurus names are different. In this case, rename
#'   should be a named vector with the target names used in the thesaurus as
#'   names, and the original names as provided in 'traitName' as value. E.g.
#'   `renam = c()`
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
#' 
#' 
#' ## Example: matching of original names to thesaurus
#' 
#' dataset2 <- as.traitdata(heteroptera_raw, 
#'   taxa = "SpeciesID", 
#'   traits = c("Body_length", "Antenna_Seg1", "Antenna_Seg2",
#'     "Antenna_Seg3", "Antenna_Seg4", "Antenna_Seg5", "Hind.Femur_length"),
#'   units = "mm", 
#'   keep = c(sex = "Sex", references = "Source", lifestage = "Wing_development"),
#'   metadata = list(
#'     bibliographicCitation = attributes(heteroptera_raw)$citeAs, 
#'     license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'     )
#' )
#' 
#' dataset2 <- mutate.traitdata(dataset2, antenna_length = Antenna_Seg1 + Antenna_Seg2 + Antenna_Seg3 + Antenna_Seg4 + Antenna_Seg3 )
#' 
#' 
#' traits2 <- as.thesaurus(
#'  body_length = as.trait("body_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"), 
#'  antenna_length = as.trait("antenna_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Antenna_length"),
#'  metafemur_length = as.trait("metafemur_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
#')
#'
#' dataset2Std <- standardize.traits(dataset2, 
#'     thesaurus = traits2, 
#'     rename = c(Body_length = "body_length", 
#'                antenna_length = "antenna_length", 
#'                Hind.Femur_length = "metafemur_length"
#'                )
#'     )
#' 
#' 

standardize.traits <- function(x,
                               thesaurus, 
                               rename = NULL,
                               categories = c("No", "Yes"), 
                               output = "logical",
                               ...
                               ) {
  
  x$traitNameStd <- x$traitName
  
  # build lookup data.frame from thesaurus object
  lookup <- do.call(rbind, lapply(thesaurus,data.frame))
 
  # if no identifier is provided, set integer values
  if(is.null(levels(lookup$identifier))) lookup$identifier <- as.factor(seq_along(lookup$trait))
  
  
  # map user-provided trait names to thesaurus (i.e. set traitNameStd)
  
  ## if rename provides user name
  if(!is.null(names(rename))) {
    levels(x$traitNameStd) <- rename[match(levels(x$traitName), names(rename) )]
  }
  
  ## if thesaurus provides user name
  if(is.null(rename) && length(thesaurus) == length(levels(x$traitName)) && !is.null(names(thesaurus))) { 
    levels(x$traitNameStd) <- names(thesaurus)[match(levels(x$traitName), names(thesaurus) )] 
  }
  
  # merge lookup table into original data frame based on user provided trait name mapping
  out <- merge.data.frame(x, lookup[,c("trait","identifier", "expectedUnit" )], by.x = "traitNameStd", by.y = "trait", sort = FALSE )
 
  ## rename columns according to ETS
  colnames(out)[colnames(out) == "trait"] <- "traitNameStd"
  colnames(out)[colnames(out) == "expectedUnit"] <- "traitUnitStd"
  colnames(out)[colnames(out) == "identifier"] <- "traitID"
 
  # generate standardized trait vector
 
  out$traitValueStd <- NA
 
  traits <- levels(out$traitNameStd) #levels(lookup$trait) #
 
  for(i in traits) { # iterate over all trait categories (by user provided names)
   
   # harmonize logical values
   if(length(lookup[lookup$trait == i,]$valueType) == 1 ) {warning("trait value has not been harmonized to standard terms! To perform standardization provide field 'valueType', as well as 'traitUnitStd' and 'factorLevels' for numeric and factorial traits, respectively!")} else {
     if(lookup[lookup$trait == i,]$valueType == "logical") {
       templist <- split(out, f = out$traitNameStd) 
       out[out$traitNameStd == i,"traitValueStd"] <- fixlogical(templist[[i]]$traitValue, output = output, categories = categories)
     }
     
     ## factor level harmonization
     if(lookup[lookup$trait == i,]$valueType == "categorical") { 
       subset(out, traitNameStd == i)$traitValueStd 
       
     } ## end of factor level harmonization
     
     
     ## unit conversion:
     if(lookup[lookup$trait == i,]$valueType == "numeric") {

       unit_original <- droplevels(subset(out, traitNameStd == i)$traitUnit)
       unit_target <- droplevels(subset(out, traitNameStd == i)$traitUnitStd)
       
       # case 1: homogeneous units for the entire trait
       if(length(levels(unit_original)) == 1 && length(levels(unit_target)) == 1) {
         
         unit_original <- as.character(levels(unit_original))
         unit_target <- as.character(levels(unit_target))
         
         # extract original value
         value_original <- subset(out, traitNameStd == i)$traitValue * units::ud_units[[unit_original]]
         
         # create vector with standardized value and write into output
         value_standardized <- value_original
         units(value_standardized) <- units::parse_unit(unit_target)
         out[out$traitNameStd == i, "traitValueStd"] <- value_standardized
         
         
       } else {     # case 2: heterogeneous units used within a single trait
         
         # extract original value
         value_original <-  subset(out, traitNameStd == traits[i])$traitValue
         
         # convert value in standardized value and write into output
         for(j in seq_along(value_original))  {
           
           value_original_j <- value_original[j] * units::ud_units[[unit_original[j]]] 
           
           value_standardized_j <- value_original_j
           units(value_standardized_j) <- units::parse_unit(unit_target[j])
           out[out$traitNameStd == i,"traitValueStd"][j] <- value_standardized_j
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
 attribs$row.names <- seq_along(out[,1])
 attributes(out) <- attribs
 
 attr(out, "traits") <- lookup
 
 return(out)
}


#' Standardize trait datasets
#' 
#' @description wrapper that applies `standardize.taxonomy()` and
#'   `standardize.traits()` in one go.
#' 
#' @param ... parameters as described for `standardize.traits()` and `standardize.taxonomy()`.
#' 
#' @inheritParams standardize.traits 
#' @inheritParams standardize.taxonomy
#' 
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
