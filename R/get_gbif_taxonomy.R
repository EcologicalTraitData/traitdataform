#' Get accepted canonical names and taxonomy for a given species name
#'
#' @param x a character string or vector of species names.
#' @param subspecies logical. If TRUE (default), the given name is resolved to
#'   subspecies epithet, otherwise it will be mapped to species level. 
#' @param fuzzy logical. If TRUE, function tries fuzzy matching for species
#'   requests. May produce output, if normal matching fails. (not working!)
#' @param verbose logical. If FALSE, warnings and messages are suppressed.
#'
#' @return a data.frame mapping the user supplied names to the accepted taxon
#'   names and higher taxonomic information (kingdom, phylum, class, order,
#'   family, genus).
#'
#' @details If 'synonym' is returned as TRUE, the user provided name has been
#'   identified as a synonym and was mapped to an accepted name. The field
#'   confidence reports the confidence of the matching procedure performed by
#'   the function 'get_gbifid_()' of the package 'taxize'. The taxonID is a
#'   globally valid URI that links to the taxon description of the GBIF backbone
#'   taxonomy.
#'
#' @import taxize
#' @importFrom data.table rbindlist
#' @export
#'
#' @examples
#'
#' get_gbif_taxonomy(c("Chorthippus albomarginatus", "Chorthippus apricarius", 
#'   "Chorthippus biguttulus", "Chorthippus dorsatus", "Chorthippus montanus", 
#'   "Chorthippus parallelus", "Chrysochraon dispar", "Conocephalus dorsalis", 
#'   "Conocephalus fuscus", "Decticus verrucivorus", "Euthystira brachyptera", 
#'   "Gomphocerippus rufus", "Gryllus campestris", "Metrioptera roeselii", 
#'   "Omocestus viridulus", "Phaneroptera falcata", "Platycleis albopunctata", 
#'   "Spec", "Stenobothrus lineatus", "Stenobothrus stigmaticus", 
#'   "Stethophyma grossum", "Tetrix kraussi", "Tetrix subulata", 
#'   "Tetrix tenuicornis", "Tetrix undulata", "Tettigonia cantans", 
#'   "Tettigonia viridissima")
#'   )
#'   
#' get_gbif_taxonomy("Acrocephalus familiaris kingi", subspecies = FALSE)
#' get_gbif_taxonomy("Vicia")

get_gbif_taxonomy <- function(x, subspecies = TRUE, fuzzy = TRUE, verbose = TRUE) {

  if(length(x) > 1) { # recursive wrapping for vectorized input
    out <- lapply(x, get_gbif_taxonomy)
    out <- data.table::rbindlist(out, fill = TRUE) # combine into data.frame

  } else {
    
    if(nchar(gsub(" ","",x)) <= 1 || is.null(x)) x <- NULL
    
    # spellchecking: resolve names using data source 11 (GBIF Backbone Taxonomy)
    resolved <- taxize::gnr_resolve(x,
                                    preferred_data_sources = c(11),
                                    best_match_only = TRUE,
                                    canonical = TRUE)

    # return NA for unsuccessful matches
    if(is.null(resolved$matched_name2) || nchar(gsub(" ","",resolved$matched_name2)) == 0 ) {
      out <- data.frame(user_supplied_name = x)
      attributes(out)$warning <- paste("No matching species name found!")
      out$warnings <- paste(out$warnings, attributes(out)$warning, collapse = "; ")
      
    } else {
      
    # get gbif ID and detailled information, e.g. synonym status
    temp <- taxize::get_gbifid_(resolved$matched_name2)[[1]]
    
    # switch for allowing for fuzzy matching
    if(any(temp$matchtype == "EXACT") || !fuzzy) temp <- subset(temp, matchtype == "EXACT")
     
    # if given name is a synonym, do a new request for the accepted species name
    if(all(temp$status == "SYNONYM")) {

        out <- get_gbif_taxonomy(temp$species[which.max(temp$confidence)])
        out$synonym = TRUE
        out$user_supplied_name = x
        attributes(out)$warning <- paste("Synonym provided! Automatically set to accepted species Name!")
        out$warnings <- paste(out$warnings, attributes(out)$warning, collapse = "; ")
    } else {  # if given name is an accepted name, return result into 'out'
      if(any(temp$status %in% c("ACCEPTED", "DOUBTFUL") )) {
        temp <- subset(temp, status %in% c("ACCEPTED", "DOUBTFUL"))
        out <- temp[which.max(temp$confidence),]
        # add choice for fuzzy matching which returns warning
      
    
      out <- data.frame(scientificName = x, 
                   synonym = FALSE, 
                   scientificNameStd = temp$canonicalname, 
                   author = sub(paste0( temp$canonicalname," "), "", out$scientificname),
                   taxonRank = out$rank,
                   confidence = out$confidence,
                   kingdom = if(is.null(out$kingdom)) NA else out$kingdom,
                   phylum = if(is.null(out$phylum)) NA else out$phylum,
                   class = if(is.null(out$class)) NA else out$class,
                   order = if(is.null(out$order)) NA else out$order,
                   family = if(is.null(out$family)) NA else out$family,
                   genus = if(is.null(out$genus)) NA else out$genus,
                   taxonomy = "GBIF Backbone Taxonomy", 
                   taxonID = paste0("http://www.gbif.org/species/", out$usagekey, ""),
                   warnings = ""
      )
      }
    }
 

      if(nchar(as.character(out$warnings)) > 3 & verbose) warning( out$warnings)
    
  }

  }
  
  
  class(out) <- c("data.frame", "taxonomy")
  
  rankorder <- c("kingdom", "phylum", "class", "order", "family", "genus", "species", "subspecies")
  
  # eliminate infraspecies epithet if subspecies == TRUE
  if(!subspecies && match(out$taxonRank, rankorder) > 6) {
    
    if(length(strsplit(as.character(out$scientificName), " ")[[1]]) > 2) {
      x <- paste(strsplit(as.character(out$scientificName), " ")[[1]][1:2], collapse = " ")
      out <- get_gbif_taxonomy(x)
      out$warnings <- paste(out$warnings, "provided subspecies name has been mapped to species!", sep = "; ") 
    } else {
      out$warnings <- paste(out$warnings, "no mapping of subspecies name to species was possible!", sep = "; ")
    }
    
  }
  return(out)
}
