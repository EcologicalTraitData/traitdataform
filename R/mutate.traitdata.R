#' Mutate traits within a traitdata object.
#' 
#' This function allows to transform, factorize, or combine trait measurements
#' into compound measurements or update factor levels into binaries.
#' 
#' @param .data the traitdata object to transform
#' @param ... named parameters giving definitions of new columns.
#'   
#' @return an updated traitdata object with the new trait measures or facts
#'   appended to the original table. If the given trait name has been refined,
#'   it will be replaced.
#'   
#' @details Note that units will not be maintained or refined. They can be
#'   assigned later through the `thesaurus()` function.
#' @export
#' 
#' @examples
#' 
#' dataset3 <- as.traitdata(arthropodtraits,
#'                          taxa = "SpeciesID",
#'                          traits = c("Body_Size", "Dispersal_ability", "Feeding_guild","Feeding_guild_short", "Feeding_mode", "Feeding_specialization", "Feeding_tissue", "Feeding_plant_part", "Endophagous_lifestyle", "Stratum_use", "Stratum_use_short"), 
#'                          units = c(Body_Size = "mm", Dispersal_ability = "unitless"),
#'                          keep = c(measurementRemark = "Remark")
#' )
#' head(dataset3)
#' 
#' updated <- mutate.traitdata(dataset3, predator = Feeding_guild == "c" )
#' head(updated)
#' levels(updated$traitName)


mutate.traitdata <- function(.data, 
                             ...
                             ) {
  stopifnot(is.data.frame(.data) || is.list(.data) || is.environment(.data))
  
  columns <- names(.data[,-which(names(.data) %in% c("traitName", "traitValue", "traitUnit"))])
  
  #if no occurence ID is provided
  temp <- reshape::cast(.data, eval(expression(paste(paste(columns, collapse =" + "), "~ traitName"))), value = 'traitValue') 
  # else group on level of occurences
  
  out_traits <- as.list(substitute(list(...))[-1])
  out_traits <- out_traits[names(out_traits) != ""]
  
  for (col in names(out_traits)) {
    units <- 
    temp[[col]] <- eval(out_traits[[col]], temp, parent.frame())
  }
  class(temp) <- "data.frame"
  
  out <- reshape::melt(temp, 
                       measure.vars = names(out_traits), 
                       id.vars = c("scientificName", 
                                   c("occurenceID")["occurenceID" %in% names(temp)],
                                   c("measurementID")["measurementID" %in% names(temp)]), 
                       variable_name = "traitName"
                       ) 
  
  names(out)[names(out) == "value"] <- "traitValue"
  row.names(out) <- seq_along(out[,1])
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  plyr::rbind.fill(subset(.data, !traitName %in% names(out_traits)), out)
}


