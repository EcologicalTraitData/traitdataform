

#' Title
#'
#' @param x 
#' @param reference 
#' @param infraspecies 
#' @param fuzzy 
#' @param verbose 
#' @param return 
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

  if(!"traitdata" %in% class(x)) mapping(x, ...)
    
  temp <- get_gbif_taxonomy(levels(x$scientificName), infraspecies = infraspecies, fuzzy = fuzzy, verbose = verbose)
  
  out <- merge(x, temp[, c(return, "user_supplied_name")], by.x = "scientificName", by.y = "user_supplied_name")
  
  #TODO: produce warning for unmatched names!
  # sort columns according to glossary of terms
  temp <- temp[, order(match(names(temp), glossary$columnName) )]
  
  class(temp) <- c("data.frame", "traitdata")
  return(out)
}


#' Title
#'
#' @param x 
#' @param map 
#' @param thesaurus 
#' @return std
#' @export
#'
standardize.traits <- function(x,
                               thesaurus, 
                               traitmap = NULL, 
                               categories = c("No", "Yes"), 
                               output = "logical"
                               ) {
  
  x$traitNameStd <- x$traitName
  
  # perform renaming following sequence
  if(length(traitmap) == length(levels(x$traitName)) && is.null(names(traitmap))) { 
    levels(x$traitNameStd) <- traitmap
  }
  
  # perform renaming following named vector
  if(!is.null(names(traitmap))) {
    levels(x$traitNameStd) <- traitmap[match(levels(x$traitName), names(traitmap) )]
  }
  
 lookup <- data.frame(traitNameStd = thesaurus$traitName, 
                      traitID = thesaurus$traitID,
                      traitUnitStd = as.factor(thesaurus$traitUnit),
                      row.names = NULL
                      )
 temp <- merge(x, lookup, by = "traitNameStd", sort = FALSE )

 ## generate standardized trait vector
 
 temp$traitValueStd <- NA
 
 #templist <- split(temp, f = temp$traitNameStd) 
 
 traits <- levels(temp$traitName)
 
 for(i in length(traits)) {
   
   # harmonize logical values
   if(thesaurus[i,]$valueType == "logical") {
     subset(temp, traitName == traits[i])$traitValueStd <- fixlogical(templist[[i]]$traitValue, output = output, categories = categories)
   }
   
   ## factor level harmonization
   if(thesaurus[i,]$valueType == "factor") { 
     subset(temp, traitName == traits[i])$traitValueStd 
     
   } ## end of factor level harmonization
   
   ## unit conversion:
   if(thesaurus[i,]$valueType == "numeric") {
     
     unit_original <- droplevels(subset(temp, traitName == traits[i])$traitUnit)
     unit_target <- droplevels(subset(temp, traitName == traits[i])$traitUnitStd)

     # case 1: homogeneous units for the entire trait
     if(length(levels(unit_original)) == 1 && length(levels(unit_target)) == 1) {
      
       value_original <-  subset(temp, traitName == traits[i])$traitValue * units::ud_units[[levels(unit_original)]]
       temp[temp$traitName == traits[i],"traitValueStd"] <- units::set_units(value_original, units::parse_unit(levels(unit_target)))
        
     } else {     # case 2: heterogeneous units used within a single trait
       
        value_original <-  subset(temp, traitName == traits[i])$traitValue
        for(j in seq_along(value_original))  {
          
          value_original_j <- value_original[j] * units::ud_units[[unit_original[j]]] 
          temp[temp$traitName == traits[i],"traitValueStd"][j] <- units::set_units(value_original_j , units::parse_unit(unit_target[j])) 
        }
        
     }
     
   } ## end of unit conversion
     
 }
 
 # sort columns according to glossary of terms
 temp <- temp[, order(match(names(temp), glossary$columnName) )]
 
 class(temp) <- c("data.frame", "traitdata")
 return(temp)
}


#' Title
#'
#' @param ... 
#'
#' @return std
#' @export
#'
standardize <- function(..., 
                        verbose = NULL,
                        warnings = NULL) {standardize.traits(standardize.taxonomy( ...), ...)}
