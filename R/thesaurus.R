#' Title
#'
#' @param x 
#' @param replace 
#' @param appliestoall 
#' @param ... 
#'
#' @return std
#' @export
#'
#' @examples
#' 
#' traits6 <- thesaurus(
#' traitID = paste0("A", 1:9),
#' traitName = c("Body_Size", "Dispersal_ability", "Feeding_guild_short", "Feeding_mode", "Feeding_specialization", "Feeding_tissue", "Feeding_plant_part", "Endophagous_lifestyle", "Stratum_use_short"),
#' valueType = c("numeric", "numeric", "factor", "factor", "factor", "factor", "factor", "factor", "factor"), 
#' factorLevels = c("", "", "predator; detritivore; fungivore; herbivore; omnivore", "chewing; extraintestinal; sucking", "monophagous; oligophagous; polyphagous", "", "", "", "" ),
#' measurementUnit = c("cm","unitless","","","","","","","") 
#' )
#' 

thesaurus <- function(x = NULL,
                      replace = NULL,
                      appliestoall = NULL,
                      ...) {
  
  
  if(class(x) == "data.frame") {
    if(!c("traitName", "traitID", "traitDescription", "measurementType") %in% names(x)) {
      message("Dataset does not match expected column names.")
        if(!is.null(replace)) {
          message("I'm using parameter 'replace' for renaming!")
          x <- reshape::rename(x, replace)
          if(!c("traitName", "traitID", "traitDescription", "measurementType") %in% names(x)) stop("Parameter 'replace' must at least provide mapping for 'traitName', 'traitID', 'traitDescription', 'measurementType'")
        } else { stop("Provide mapping of column names in parameter 'replace'!")}
    }
    out <- x
  } else {
    out <- thesaurus(data.frame(...))
    
  }
  
  class(out) <- c("thesaurus", "data.frame")
  return(out)
}

