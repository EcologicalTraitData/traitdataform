#' Title
#'
#' @param x
#' @param infraspecies
#' @param fuzzy
#' @param verbose
#'
#' @return
#' @import taxize
#' @import data.table
#' @export
#'
#' @examples
#'
#' get_gbif_taxonomy(c("Chorthippus albomarginatus", "Chorthippus apricarius", "Chorthippus biguttulus", "Chorthippus dorsatus", "Chorthippus montanus", "Chorthippus parallelus", "Chrysochraon dispar", "Conocephalus dorsalis", "Conocephalus fuscus", "Decticus verrucivorus", "Euthystira brachyptera", "Gomphocerippus rufus", "Gryllus campestris", "Metrioptera roeselii", "Omocestus viridulus", "Phaneroptera falcata", "Platycleis albopunctata", "Spec", "Stenobothrus lineatus", "Stenobothrus stigmaticus", "Stethophyma grossum", "Tetrix kraussi", "Tetrix subulata", "Tetrix tenuicornis", "Tetrix undulata", "Tettigonia cantans", "Tettigonia viridissima"))
#'

get_gbif_taxonomy <- function(x, infraspecies = FALSE, fuzzy = FALSE, verbose = TRUE) {

  if(length(x) > 1) {
    out <-  lapply(x, get_gbif_taxonomy)  # for vectorized input
    out <- data.table::rbindlist(out, fill = TRUE) # combine into data.frame

  } else {

    # spellchecking: resolve names using data source 11 (GBIF Backbone Taxonomy)

    resolved <- taxize::gnr_resolve(x,
                                    preferred_data_sources = c(11),
                                    best_match_only = TRUE,
                                    canonical = TRUE)

    if(is.null(resolved$matched_name2) ) {
      out <- data.frame(user_supplied_name = x)
      attributes(out)$warning <- paste("No matching species name found!")
    } else {

    temp <- taxize::get_gbifid_(resolved$matched_name2)[[1]]

    if(!fuzzy) temp <- subset(temp, matchtype == "EXACT")
    if(!infraspecies) temp <- subset(temp, rank == "species") #ask for rank according to name resolution provided

    if(all(temp$status == "SYNONYM")) {
      if(length(unique(temp$species)) == 1) {
        out <- get_gbif_taxonomy(unique(temp$species))
        #attributes(out)$warning <- paste("Synonym provided! Automatically set ScientificName to accepted species Name!")
        out$synonym = TRUE
        out$user_supplied_name = x
      }
      if(length(unique(temp$species)) > 1) out <- get_gbif_taxonomy(temp$species[which.max(temp$rank)])
      attributes(out)$warning <- paste("Synonym provided! Automatically set ScientificName to accepted species Name!")
      out$synonym = TRUE
      out$user_supplied_name = x
    } else {
      if(any(temp$status == "ACCEPTED")) {
        temp <- subset(temp, status == "ACCEPTED")
        out <- temp
        # add choice for fuzzy matching which returns warning
            }

      out <- cbind(user_supplied_name = x, synonym = FALSE,   scientificName = out$species,fullname = out$scientificname, out[,c("rank", "confidence", "kingdom",  "phylum", "class","order", "family", "genus")], taxonomy = "GBIF Backbone Taxonomy",  taxonID = out$usagekey)

    }
  }

  }
  return(out)
}
