#' Get accepted canonical names and taxonomy for a given species name
#'
#' The function maps user provided names to accepted species names.
#'
#' @param x a character string or vector of species names.
#' @param subspecies logical. If TRUE (default), the given name is resolved to
#'   subspecies epithet, otherwise it will be mapped to species level.
#' @param higherrank logical. If FALSE (default), it will not allow remapping of
#'   unknown species names to higher taxon ranks (e.g. genus).
#' @param verbose logical. If FALSE (default), warnings and messages are
#'   suppressed.
#' @param fuzzy logical. Defaults to TRUE to deal with misspelled names. May
#'   produce wrong assignments in case of very similar taxon names. If FALSE
#'   (default), names are only resolved to exactly matching taxa on GBIF
#'   taxonomy service.
#' @param conf_threshold numerical, ranging from 0 to 100 (default value = 90).
#'   Defines the confidence level of the request to be accepted. To cover for
#'   misspellings and errors, could go as low as 50.
#' @param resolve_synonyms logical. If TRUE (default), user provided synonyms
#'   are mapped to the accepted names on GBIF taxonomy service.
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
#' get_gbif_taxonomy("Vicia")

get_gbif_taxonomy <- function(x, 
                              subspecies = TRUE, 
                              higherrank = FALSE, 
                              verbose = FALSE, 
                              fuzzy  = TRUE, 
                              conf_threshold = 90,
                              resolve_synonyms = TRUE
                              ) {
  
  matchtype = status = confidence = NULL
  
  # get gbif mappings

  temp <- taxize::get_gbifid_(x, messages = verbose)
  
  # loop over all species returns 
  
  for(i in 1:length(temp)) {
    
    warning_i = ""
    synonym_i = FALSE
    
    # buildup empty returns
    
    if(nrow(temp[[i]]) == 0) {
      warning_i <- paste("No matching species concept!")
      temp[[i]] <- data.frame(verbatimScientificName = x[i], matchtype = "NONE", status = "NA", rank = "species", stringsAsFactors = FALSE)
      
    }
    
    # clean out fuzzy  matches, if not allowed
    
    if(!fuzzy & nrow(temp[[i]]) > 0)  {   
      temp[[i]] <- subset(temp[[i]], matchtype != "FUZZY")
      if(nrow(temp[[i]]) == 0) {
        warning_i <- paste(warning_i, "Fuzzy matching might yield results.")
      }
    }
    
    #clean out higherrank matches, if not allowed
    if(!higherrank) {
      temp[[i]] <- subset(temp[[i]], matchtype != "HIGHERRANK")
      if(nrow(temp[[i]]) == 0) {
        warning_i <- paste(warning_i, "No matching species concept!")
      }
    }
    
    # check for confidence threshold 
    
    if(!is.null(conf_threshold) & nrow(temp[[i]]) > 0) {
      temp[[i]] <- subset(temp[[i]], confidence >= conf_threshold)
      if(nrow(temp[[i]]) == 0) {
        temp[[i]] <- data.frame(verbatimScientificName = x[i], matchtype = "NONE", status = "NA", rank = "species", stringsAsFactors = FALSE)
        warning_i <- paste(warning_i, "No match! Check spelling or lower confidence threshold!")
      }
    }
    
    
    # remove all synonyms, if accepted exact match is found
    
    if(any(temp[[i]]$status == "ACCEPTED")) {
      
      temp[[i]] <- subset(temp[[i]], status == "ACCEPTED")
      temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
      #warning_i <- paste(warning_i, "Automatically mapped to accepted species name!", sep = " ")
      if(nrow(temp[[i]]) > 1) {
        temp[[i]] <- temp[[i]][1,]
        warning_i <- paste(warning_i, "Selected first of multiple equally ranked concepts!")
      }
    }
    
    
    # resolve all synonyms, if allowed 
     
    if(nrow(temp[[i]]) > 0 && !any(temp[[i]]$status == "ACCEPTED") & any(temp[[i]]$status == "SYNONYM")) {
      if(resolve_synonyms) {
          keep <- temp[i]
          temp[i] <- taxize::get_gbifid_(temp[[i]]$species[which.max(temp[[i]]$confidence)], messages = verbose)
          if(temp[[i]][1,]$status == "ACCEPTED") {
          
            temp[[i]] <- subset(temp[[i]], matchtype == "EXACT" & status == "ACCEPTED")
            temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
            if(nrow(temp[[i]]) > 1) {
              temp[[i]] <- temp[[i]][1,]
              warning_i <- paste(warning_i, "Selected first of multiple equally ranked concepts!")
            }
            warning_i <- paste(warning_i, "A synonym was mapped to the accepted species concept!", sep = " ")
            synonym_i = TRUE
            
          } else {
            status <- temp[[i]][1,]$status
            temp[i] <- keep
            if(nrow(temp[[i]]) > 1) {
              temp[[i]] <- temp[[i]][1,]
              warning_i <- paste(warning_i, "Selected first of multiple equally ranked concepts!")
            }
            warning_i <- paste0(warning_i, " Resolved synonym '", temp[[i]]$species,"' is labelled '", status, "'. Clarification required!" )
          }
      
      } else {
        
          temp[[i]] <- subset(temp[[i]], status == "SYNONYM")
          temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
          warning_i <- paste(warning_i, "The provided taxon seems to be a synonym of '", temp[[i]]$species,"'!", sep = "")
          
      }
    }
      
    # check for doubtful status 
    
    if(nrow(temp[[i]]) > 0 && all(temp[[i]]$status == "DOUBTFUL")) {
      
      temp[[i]] <- subset(temp[[i]], status == "DOUBTFUL")
      warning_i <- paste(warning_i, "Mapped concept is labelled 'DOUBTFUL'!")
      
      temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
      #warning_i <- paste(warning_i, "Automatically mapped to accepted species name!", sep = " ")
      if(nrow(temp[[i]]) > 1) {
        temp[[i]] <- temp[[i]][1,]        
        warning_i <- paste(warning_i, "Selected first of multiple equally ranked concepts!")
      }
    }
    
    
    # 3. check rankorder of result
  
    rankorder <- c("kingdom", "phylum", "class", "order", "family", "genus", "species", "subspecies")
    
    if(nrow(temp[[i]]) > 0 && match(temp[[i]]$rank, rankorder) > 7 & !subspecies) {
      
      if(length(strsplit(as.character(temp[[i]]$canonicalname), " ")[[1]]) > 2) {
        
        temp[i] <- taxize::get_gbifid_(paste(strsplit(names(temp[i]), " ")[[1]][1:2], collapse = " "), messages = verbose)
        temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
        
        warning_i<- paste(warning_i, "Subspecies has been remapped to species concept!", sep = " ") 
        
      } else {
        
        temp[[i]] <- data.frame(verbatimScientificName = x[i], matchtype = "NONE", rank = "subspecies", stringsAsFactors = FALSE)
        warning_i <- paste(warning_i, "No mapping of subspecies name to species was possible!", sep = " ")
      }
      
    }
    
    if(nrow(temp[[i]]) > 0 && temp[[i]]$matchtype == "HIGHERRANK") {
      if(higherrank) {
        temp[[i]] <- subset(temp[[i]], temp[[i]]$confidence == max(temp[[i]]$confidence))
        warning_i <- paste(warning_i, "No matching species concept! Entry has been mapped to higher taxonomic level.")
      } else {
        temp[[i]] <- data.frame(verbatimScientificName = x[i], matchtype = "NONE", rank = "highertaxon", stringsAsFactors = FALSE)
        warning_i <- paste("No matching species concept!", warning_i)
      }
    } 
    
    
    # 4. create structured output
    if(nrow(temp[[i]]) > 0 && temp[[i]]$matchtype != "NONE") {
      
      temp[[i]] <- data.frame(
        verbatimScientificName = x[i], 
        synonym = synonym_i, 
        scientificName = temp[[i]]$canonicalname, 
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
        warnings = NA,
        stringsAsFactors = FALSE
      )
    } else {
      temp[[i]] <- data.frame(verbatimScientificName = x[i], warnings = NA, stringsAsFactors = FALSE )
    }
    
    temp[[i]]$warnings <- warning_i
    
    if(verbose & nchar(warning_i) >= 1) warning(warning_i)
  }
  
  #compile output data.frame 
  
  out <- data.table::rbindlist(temp, fill = TRUE)
  
  class(out) <- c("data.frame", "taxonomy")
  
  return(out)
    
      
}
 
    
    

  
