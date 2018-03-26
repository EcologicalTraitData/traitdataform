#' Get accepted canonical names and taxonomy for a given species name
#'
#' The function maps user provided names to accepted species names.
#'
#' @param x a character string or vector of species names.
#' @param subspecies logical. If TRUE (default), the given name is resolved to
#'   subspecies epithet, otherwise it will be mapped to species level.
#' @param resolve_synonyms logical. If TRUE (default), user provided synonyms
#'   are mapped to the accepted names on GBIF taxonomy service.
#' @param fuzzy logical. If FALSE (default), names are only resolved to exactly
#'   matching taxa on GBIF taxonomy service. Setting to TRUE may produce matches
#'   when failing otherwise.
#' @param verbose logical. If FALSE (default), warnings and messages are
#'   suppressed.
#'
#' @return a data.frame mapping the user supplied names to the accepted taxon
#'   names and higher taxonomic information (kingdom, phylum, class, order,
#'   family, genus).
#'
#' @details The function relies on package 'taxize' by Scott Chamberlain. It
#'   uses the spell-checking and fuzzy matching algorithms provided by Global
#'   Names Resolver (`taxize::gnr_resolve()`) and forwards synonyms to the
#'   accepted names as provided by GBIF Backbone Taxonomy
#'   (`taxize::get_gbif_id_()`).
#'
#'   If 'synonym' is returned as TRUE, the user provided name has been
#'   identified as a synonym and was mapped to an accepted name.
#'
#'   The field confidence reports the confidence of the matching procedure
#'   performed by the function `get_gbifid_()` of the package 'taxize'. The
#'   taxonID is a globally valid URI that links to the taxon description of the
#'   GBIF backbone taxonomy.
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

get_gbif_taxonomy <- function(x, subspecies = TRUE, verbose = FALSE, fuzzy  = FALSE, resolve_synonyms = TRUE) {
  
  # spellchecking: resolve all names using data source 11 (GBIF Backbone Taxonomy)
  resolved <- taxize::gnr_resolve(x,
                                  preferred_data_sources = c(11),
                                  best_match_only = TRUE,
                                  canonical = TRUE,
                                  with_context = TRUE)
  
  # fix case where input string has content of length 1 or 0 to NA (otherwise get_gbifid_() would stop with an error). 
  resolved$matched_name2[resolved$matched_name2 == "" | nchar(gsub(" ","",resolved$matched_name2)) <= 1 ] <- NA
  
  # map resolved names to gbif taxonomy server
  temp <- taxize::get_gbifid_(resolved$matched_name2, verbose = verbose)

  for(i in 1:length(temp)) {
    
    
    if(nrow(temp[[i]]) >= 1) {
      
    synonym_i = FALSE
    warning_i = ""
    
    # 0. produce warning for bad name resolution
    if(resolved$score[i] < 0.75) warning_i = paste("low name resolution, e.g. due to misspelled name. please check!")
    
    # 1. remap to accepted species name, if no synonyms are accepted.   
    
    if(resolve_synonyms && all(temp[[i]]$status[temp[[i]]$matchtype == "EXACT" ] == "SYNONYM" )) {
      
      temp[i] <- taxize::get_gbifid_(temp[[i]]$species[which.max(temp[[i]]$confidence)], verbose = verbose)
      warning_i <- paste(warning_i, "A synonym was provided! Automatically mapped to accepted species name!")
      synonym_i = TRUE
    }
    
    # 2. if not allowed, omit subspecies mapping and remap species level
    
    rankorder <- c("kingdom", "phylum", "class", "order", "family", "genus", "species", "subspecies")
    
    # eliminate infraspecies epithet if subspecies == FALSE
    if(!subspecies && match(temp[[i]]$rank, rankorder) > 7) {
      
      if(length(strsplit(as.character(temp[[i]]$canonicalname), " ")[[1]]) > 2) {
        temp[i] <- get_gbifid_(paste(strsplit(as.character(out$scientificName), " ")[[1]][1:2], collapse = " "), verbose = verbose)
        
        warning_i<- paste(warning_i, "provided subspecies name has been remapped to species!", sep = " ") 
      } else {
        warning_i <- paste(warning_i, "no mapping of subspecies name to species was possible!", sep = " ")
      }
    }
   
    # 3. select exact matches, or fall back on fuzzy match if allowed
    
    if(!any(temp[[i]]$matchtype == "EXACT")) {
      if(fuzzy) { 
        temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
        warning_i <- paste(warning_i, "No exact match found! best fuzzy match was selected.", sep = " ")
      } else {
        temp[[i]] <- data.frame()
        warning_i <- paste(warning_i,"No matching species name found!")
      }
    } else {
      temp[[i]] <- subset(temp[[i]], matchtype == "EXACT" & status == "ACCEPTED")
      temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
      
    }
    

    # 4. create structured output
    
      
      temp[[i]] <- data.frame(
                          scientificName = x[i], 
                          synonym = synonym_i, 
                          scientificNameStd = temp[[i]]$canonicalname, 
                          author = sub(paste0(temp[[i]]$canonicalname," "), "", temp[[i]]$scientificname),
                          taxonRank = temp[[i]]$rank,
                          confidence = temp[[i]]$confidence,
                          kingdom = if(is.null(temp[[i]]$kingdom)) NA else temp[[i]]$kingdom,
                          phylum = if(is.null(temp[[i]]$phylum)) NA else temp[[i]]$phylum,
                          class = if(is.null(temp[[i]]$class)) NA else temp[[i]]$class,
                          order = if(is.null(temp[[i]]$order)) NA else temp[[i]]$order,
                          family = if(is.null(temp[[i]]$family)) NA else temp[[i]]$family,
                          genus = if(is.null(temp[[i]]$genus)) NA else temp[[i]]$genus,
                          taxonomy = "GBIF Backbone Taxonomy", 
                          taxonID = paste0("http://www.gbif.org/species/", temp[[i]]$usagekey, ""),
                          warnings = warning_i
                        )
                      
    } 
    
    # 5. fix empty output to structured output
    
    if(nrow(temp[[i]]) == 0) {
      
      warning_i <- paste("No matching species name found!")
      temp[[i]] <- data.frame(scientificName = x[i])
      temp[[i]]$warnings <- warning_i
      
    }
    
    
    if(verbose & nchar(warning_i) >= 1) warning(warning_i)
  } 
    
  
  out <- rbindlist(temp, fill = TRUE)
  
  class(out) <- c("data.frame", "taxonomy")
  
  return(out)
    
      
}
 
    
    

  
