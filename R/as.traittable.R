#' Title
#'
#' @param x 
#' @param traits 
#' @param taxon 
#' @param individual 
#' @param occurence 
#' @param measurement 
#' @param keep 
#' @param drop 
#' @param na.rm 
#' @param id.vars 
#'
#' @return
#' @export
#' @import reshape
#'

as.traittable <- function(x, 
                          traits, # name of column or vector of trait names
                          taxa, # name of column or vector of species/taxon names
                          individual = NULL,  # deprecated/implemented for ambiguity
                          occurence = individual, 
                          measurement = NULL,
                          units = NULL,
                          keep = NULL,
                          drop = NULL, 
                          na.rm = TRUE,
                          id.vars = names(x)[names(x) %in% keep & !names(x) %in% drop]
) {
  
  if(length(taxa) == 1 && !is.null(taxa)) colnames(x)[colnames(x) == taxa] <- "taxon"

  if(!is.null(occurence) && length(occurence) == 1) colnames(x)[colnames(x) == occurence] <- "occurence"  #TODO specify case for self provided occurence vector
  if(!is.null(measurement) && length(measurement) == 1) colnames(x)[colnames(x) == measurement] <- "measurement"  #TODO specify case for self provided measurementID vector
  
  if(length(traits) == 1 && !is.null(traits)) {
    colnames(x)[colnames(x) == traits] <- "trait"
    
    # produce out while respecting id.vars to keep and drop
  }
  if(length(traits) > 1) {
    out <- reshape::melt(x, 
                         measure.vars = traits, 
                         variable_name = "trait", 
                         id.vars = c("taxon", 
                                     c("occurence")[!is.null(occurence)],
                                     c("measurement")[!is.null(measurement)], 
                                     id.vars),
                         na.rm = na.rm
    )
  }
  
  if(!is.null(units)) {
    if(length(units) == 1) out$unit <- units
    if(length(units) == length(traits)) out$unit <- units[match(out$trait, traits)]
    if(length(units) != length(traits) & !is.null(names(units)) ) out$unit <- as.factor(match(out$trait, names(units))) ; levels(out$unit) <- units
  } 
   
  # perform renaming if keep contains named vector
  if(!is.null(names(keep))) {
    named <- keep[names(keep) != ""]
    colnames(out)[match(named, colnames(out))] <- names(named)
  }
  
  class(out) <- c("data.frame", "traitdata")
  return(out)
  
}