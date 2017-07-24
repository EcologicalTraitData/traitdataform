#' Title
#'
#' @param x 
#' @param traits 
#' @param taxon 
#' @param individuals
#' @param occurence 
#' @param measurement 
#' @param keep 
#' @param drop 
#' @param na.rm 
#' @param id.vars 
#' @param ...
#'
#' @export
#' @import reshape
#'

as.traitdata <- function(x, 
                          traits = NULL, # name of column or vector of trait names
                          taxa, # name of column or vector of species/taxon names
                          individuals = NULL,  # deprecated/implemented for ambiguity
                          occurences = individuals,
                          datasetID = NULL,
                          measurements = NULL,
                          units = NULL,
                          keep = NULL,
                          drop = NULL, 
                          na.rm = TRUE,
                          id.vars = names(x)[names(x) %in% keep & !names(x) %in% drop],
                          thesaurus = NULL,
                          ...
) {
  
  if(!is.null(thesaurus) && "thesaurus" %in% class(thesaurus)) traits = sapply(thesaurus, function(x) x$traitName)
  
  if(length(taxa) == 1 && !is.null(taxa)) colnames(x)[colnames(x) == taxa] <- "scientificName"

  if(!is.null(occurences) && length(occurences) == 1) { 
      colnames(x)[colnames(x) == occurences] <- "occurenceID" 
      x$occurenceID <- paste(datasetID, x$occurenceID, sep = "")
    } else {
      if(!is.null(occurences) && length(occurences) == length(x$scientificName) ) {
            x$occurenceID <- paste(datasetID, occurences, sep = "")
      }
      if(is.null(occurences) && length(x$scientificName) != length(unique(x$scientificName)) ) {
        message("it seems you are providing repeated measures of traits on multiple specimens of the same species (i.e. an occurence table)! Sequential identifiers for the occuences will be added. If your dataset contains user-defined occurenceIDs you may specify the column name in parameter 'occurences'. ")
        x$occurenceID <- paste(datasetID, seq_along(x$scientificName), sep = "")
      }
      if(is.null(occurences) && length(x$scientificName) == length(unique(x$scientificName)) ) {
        message("it seems you are providing data in a species -- trait matrix. If this is not the case, please check out parameters!")
      }
    }
  
  if(!is.null(measurements) && length(measurements) == 1) colnames(x)[colnames(x) == measurements] <- "measurementID"  #TODO specify case for self provided measurementID vector
  
  if(length(traits) == 1 && !is.null(traits)) {
    colnames(x)[colnames(x) == traits] <- "traitName"
    
    # produce out while respecting id.vars to keep and drop
  }
  if(length(traits) > 1) {
    out <- reshape::melt(x, 
                         measure.vars = traits, 
                         variable_name = "traitName", 
                         id.vars = c("scientificName", 
                                     c("occurenceID")[!is.null(occurences)],
                                     c("measurementID")[!is.null(measurements)], 
                                     id.vars),
                         na.rm = na.rm
    )
  }
  
  names(out)[names(out) == "value"] <- "traitValue"
  
  if(!is.null(units)) {
    out$traitUnit <- NA
    if(length(units) == 1) out$traitUnit <- as.factor(units)
    if(length(units) == length(traits)) out$traitUnit <- as.factor(units[match(out$traitName, traits)])
    if(length(units) != length(traits) & !is.null(names(units)) ) {
      out$traitUnit <- as.factor(match(out$traitName, names(units))) 
      levels(out$traitUnit) <- units
    }
  } 
   
  
  # perform renaming if keep contains named vector
  if(!is.null(names(keep))) {
    named <- keep[names(keep) != ""]
    colnames(out)[match(named, colnames(out))] <- names(named)
  }
  
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  class(out) <- c("data.frame", "traitdata")
  return(out)
  
}