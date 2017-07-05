

#' Title
#'
#' @param x 
#' @param reference 
#' @param infraspecies 
#' @param fuzzy 
#' @param verbose 
#' @param return 
#'
#' @return
#' @export
#'
standardize.taxonomy <- function(x, reference = get_gbif_taxonomy, infraspecies = FALSE, fuzzy = FALSE, verbose = TRUE, return = c("taxonID", "scientificName", "kingdom", "taxonRank"), ...) {

  if(!"traitdata" %in% class(x)) mapping(x, ...)
    
  temp <- get_gbif_taxonomy(levels(x$scientificName_original), infraspecies = infraspecies, fuzzy = fuzzy, verbose = verbose)
  
  out <- merge(x, temp[, c(return, "user_supplied_name")], by.x = "scientificName_original", by.y = "user_supplied_name")
  
  #TODO: produce warning for unmatched names!
  
  return(out)
}


#' Title
#'
#' @param x 
#' @param map 
#' @param thesaurus 
#'
#' @return
#' @export
#'
standardize.traits <- function(x, map = NULL, thesaurus) {
  
  x$traitName <- x$traitName_original
  
  # perform renaming following sequence
  if(length(map) == length(levels(x$traitName_original)) && is.null(names(map))) { 
    levels(x$traitName) <- map
  }
  
  # perform renaming following named vector
  if(!is.null(names(map))) {
    levels(x$traitName) <- map[match(levels(x$traitName_original), names(map) )]
  }
  
 lookup <- data.frame(traitName = thesaurus$traitName, 
                      traitID = thesaurus$traitID,
                      measurementUnit = thesaurus$measurementUnit,
                      row.names = NULL
                      )
 temp <- merge(x, lookup, by = "traitName" )
 temp$measurementValue <- NA
 
 #templist <- split(temp, f = temp$traitName) 
 
 traits <- levels(temp$traitName_original)
 
 for(i in length(traits)) {
   
   # harmonize logical values
   if(thesaurus[i,]$valueType == "logical") {
     subset(temp, traitName_original == traits[i])$measurementValue <- fixlogical(templist[[i]]$measurementValue_original)
   }
   
   ## factor level harmonization
   if(thesaurus[i,]$valueType == "factor") { 
     subset(temp, traitName_original == traits[i])$measurementValue 
     
   } ## end of factor level harmonization
   
   ## unit conversion:
   if(thesaurus[i,]$valueType == "numeric") {
     
     unit_original <- droplevels(subset(temp, traitName_original == traits[i])$measurementUnit_original)
     unit_target <- droplevels(subset(temp, traitName_original == traits[i])$measurementUnit)

     # case 1: homogeneous units for the entire trait
     if(length(levels(unit_original)) == 1 && length(levels(unit_target)) == 1) {
      
       value_original <-  subset(temp, traitName_original == traits[i])$measurementValue_original * units::ud_units[[levels(unit_original)]]
       temp[temp$traitName_original == traits[i],"measurementValue"] <- units::set_units(value_original, units::parse_unit(levels(unit_target)))
        
     } else {     # case 2: heterogeneous units used within a single trait
       
        value_original <-  subset(temp, traitName_original == traits[i])$measurementValue_original
        for(j in seq_along(value_original))  {
          
          value_original_j <- value_original[j] * units::ud_units[[unit_original[j]]] 
          temp[temp$traitName_original == traits[i],"measurementValue"][j] <- units::set_units(value_original_j , units::parse_unit(unit_target[j])) 
        }
        
     }
     
   } ## end of unit conversion
     
 }
 class(out) <- c("data.frame", "traitdata")
 return(temp)
}


#' Title
#'
#' @param ... 
#'
#' @return
#' @export
#'
standardize <- function(...) {standardize.traits(standardize.taxonomy( ...), ...)}
