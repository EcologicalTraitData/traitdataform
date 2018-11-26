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
#' @details Note that units for numerical traits will not be maintained or 
#'   computed (e.g. for ratios). They should be assigned later through the 
#'   `thesaurus()` function.
#'   
#'   It is advised to mutate traits before applying `standardize.traits()`! If 
#'   the mutate function is applied to a standardised dataset, the new trait 
#'   will not be mapped automatically to the provided thesaurus. (automated
#'   re-mapping might be added in later versions of the package.)
#'   
#' @export mutate.traitdata
#' @importFrom reshape2 melt
#' @importFrom plyr rbind.fill
#' 
#' @examples
#' 
#' pulldata("arthropodtraits")
#' dataset3 <- as.traitdata(arthropodtraits,
#'                          taxa = "SpeciesID",
#'                          traits = c("Body_Size", "Dispersal_ability", 
#'                             "Feeding_guild","Feeding_guild_short", 
#'                             "Feeding_mode", "Feeding_specialization", 
#'                             "Feeding_tissue", "Feeding_plant_part", 
#'                             "Endophagous_lifestyle", "Stratum_use", 
#'                             "Stratum_use_short"), 
#'                          units = c(Body_Size = "mm", Dispersal_ability = "unitless"),
#'                          keep = c(measurementRemark = "Remark"),
#'                          metadata = list(
#'                             license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'                             )
#' )
#' head(dataset3)
#' 
#' updated <- mutate.traitdata(dataset3, predator = Feeding_guild == "c" )
#' head(updated[updated$traitName == "predator",])
#' levels(updated$traitName)
#' 
#' 
#' ## 
#' 
#' pulldata("heteroptera_raw")
#' dataset2 <- as.traitdata(heteroptera_raw,
#'                         traits = c("Body_length", "Body_width", "Body_height", "Thorax_length",
#'                                   "Thorax_width", "Head_width", "Eye_width", "Antenna_Seg1",
#'                                    "Antenna_Seg2", "Antenna_Seg3", "Antenna_Seg4", "Antenna_Seg5",
#'                                    "Front.Tibia_length", "Mid.Tibia_length", "Hind.Tibia_length",
#'                                    "Front.Femur_length", "Hind.Femur_length", "Front.Femur_width",
#'                                    "Hind.Femur_width", "Rostrum_length", "Rostrum_width", 
#'                                    "Wing_length", "Wing_width"),
#'                         taxa = "SpeciesID",
#'                         occurrences = "ID"
#' )
#' updated <- mutate.traitdata(dataset2, 
#'                             Body_shape = Body_length/Body_width, 
#'                             Body_volume = Body_length*Body_width*Body_height,
#'                             Wingload = Wing_length*Wing_width/Body_volume)
#' 
#' head(updated[updated$traitName %in% c("Body_shape", "Body_volume", "Wingload"),])

mutate.traitdata <- function(.data, 
                             ...
                             ) {
  
  traitName = NULL
  
  stopifnot(is.data.frame(.data) || is.list(.data) || is.environment(.data))
  
  in_traits <- levels(.data$traitName)
  temp <- cast.traitdata(.data)
  
  # extract mutations to apply into list
  out_traits <- as.list(substitute(list(...))[-1])
  out_traits <- out_traits[names(out_traits) != ""]
  
  # apply each list entry to matrix
  for (col in names(out_traits)) {
     
    temp[[col]] <- eval(out_traits[[col]], temp, parent.frame())
  }
  class(temp) <- "data.frame"
  
  out <- reshape2::melt(temp, 
                       measure.vars = names(out_traits), 
                       id.vars = names(temp[,
                            which(!names(temp) %in% c(in_traits,names(out_traits)))]), 
                       variable_name = "traitName",
                       na.rm = TRUE
                       ) 
  
  names(out)[names(out) == "value"] <- "traitValue"

  out <- plyr::rbind.fill(subset(.data, !traitName %in% names(out_traits)), out)

    # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  attribs <- attributes(.data)
  attribs$names <- attributes(out)$names
  attribs$row.names <- seq_along(out[,1])
  attributes(out) <- attribs
  
  return(out)
}


