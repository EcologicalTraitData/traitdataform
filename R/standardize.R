#' Standardize scientific names of species.
#'
#' @param x a traitdata object (as returned by as.traitdata()) or a data table containing at least the column 'scientificName'. 
#' @param method not functional. Will allow to chose from different sources of taxonomic reference. 
#' @param infraspecies not functional. 
#' @param fuzzy disable fuzzy matching if problems with ambiguous species names arise. 
#' @param verbose has currently no effect. 
#' @param return a character vector containing the informatoin that should be extracted into the output. Valid entries are the column names returned by function 'get_gbif_taxonomy()'.
#'
#' @return std
#' @export
#'
standardize.taxonomy <- function(x, 
                                 method = get_gbif_taxonomy, 
                                 infraspecies = FALSE, 
                                 fuzzy = FALSE, 
                                 verbose = TRUE, 
                                 return = c("taxonID", "scientificNameStd", "order", "taxonRank"), 
                                 ...) {

  #if(!"traitdata" %in% class(x)) mapping(x, ...)
    
  temp <- method(levels(droplevels(x$scientificName)), infraspecies = infraspecies, fuzzy = fuzzy, verbose = verbose)
  
  out <- merge(x, temp[, unique(c(return, "taxonID", "scientificNameStd", "scientificName", "warnings"))], by.x = "scientificName", by.y = "scientificName")
  
  #TODO: produce warning for unmatched names!
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  class(out) <- c("data.frame", "traitdata")
  return(out)
}


#' Standardize trait names and harmonize measured values and reported facts.
#'
#' @param x 
#' @param thesaurus 
#' @param rename
#' @param categories
#' @param output
#' 
#' @import units
#' @return std
#' @export 
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
 
 if(is.null(levels(lookup$traitID))) lookup$traitID <- as.factor(seq_along(lookup$traitName))
 
 lookup <- cbind(traitNameStd = names(thesaurus), lookup)
 
 temp <- merge(x, lookup[,c("traitName", "traitUnitStd", "traitID" )], by = "traitName", sort = FALSE )

 ## generate standardized trait vector
 
 temp$traitValueStd <- NA
 
 #templist <- split(temp, f = temp$traitNameStd) 
 
 traits <- unique(temp$traitName)
 
 for(i in 1:length(traits)) { # iterate over all trait categories (by user provided names)
   
   # harmonize logical values
   if(is.na(lookup[i,]$traitType) ) {warning("trait value has not been harmonized to standard terms! To perform standardization provide field 'traitType', as well as 'traitUnitStd' and 'factorLevels' for numeric and factorial traits, respectively!")} else {
     if(lookup[i,]$traitType == "logical") {
       temp[temp$traitName == traits[i],"traitValueStd"] <- fixlogical(templist[[i]]$traitValue, output = output, categories = categories)
     }
     
     ## factor level harmonization
     if(lookup[i,]$traitType == "factor") { 
       subset(temp, traitName == traits[i])$traitValueStd 
       
     } ## end of factor level harmonization
     
     ## unit conversion:
     if(lookup[i,]$traitType == "numeric") {
       
       unit_original <- droplevels(subset(temp, traitName == traits[i])$traitUnit)
       unit_target <- droplevels(subset(temp, traitName == traits[i])$traitUnitStd)
       
       # case 1: homogeneous units for the entire trait
       if(length(levels(unit_original)) == 1 && length(levels(unit_target)) == 1) {
         
         value_original <-  subset(temp, traitName == traits[i])$traitValue * units::ud_units[[levels(unit_original)]]
         temp[temp$traitName == traits[i], "traitValueStd"] <- units::set_units(value_original, units::parse_unit(levels(unit_target)))
         
       } else {     # case 2: heterogeneous units used within a single trait
         
         value_original <-  subset(temp, traitName == traits[i])$traitValue
         for(j in seq_along(value_original))  {
           
           value_original_j <- value_original[j] * units::ud_units[[unit_original[j]]] 
           temp[temp$traitName == traits[i],"traitValueStd"][j] <- units::set_units(value_original_j , units::parse_unit(unit_target[j])) 
         }
         
       }
       
     } ## end of unit conversion
     
   }
   
 }
 
 # sort columns according to glossary of terms
 temp <- temp[, order(match(names(temp), glossary$columnName) )]
 
 class(temp) <- c("data.frame", "traitdata")
 return(temp)
}


#standardize.exploratories <- function(x)


#' Title
#'
#' @param ... 
#'
#' @return std
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
