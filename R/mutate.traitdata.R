#' Mutate traits within a traitdata object.
#' 
#' This function allows to transform, factorize, or combine trait measurements 
#' into compound measurements or update factor levels into binaries.
#' 
#' @param .data the traitdata object to transform
#' @param ... named parameters giving definitions of new columns.
#' @param traits (NOT TESTED) the column name to be kept for parsing into wide-table (default
#'   is `traitName`). Note that any duplicate column that contains trait names,
#'   e.g. `traitNameStd` will be omitted.
#' @param units (NOT TESTED) the column name containing the units of numerical values
#'   (default is `traitUnit`).
#' @param values (NOT TESTED) the column name containing the trait values to be used to fill
#'   the matrix (default is `traitValue`). Duplicate columns (e.g.
#'   `traitValueStd`) will be omitted. See notes.
#'   
#' @return an updated traitdata object with the new trait measures or facts 
#'   appended to the original table. If the given trait name has been refined, 
#'   it will be replaced.
#'   
#' @details The function handles units for numerical traits and returns the new unit of the computed value in column `traitUnit`, if units of input variables were specified according to the units package.
#'   Handling of other columns than `traitName` and `traitValue` is not advised at present.    
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
#' 
#' head(updated[updated$traitName == "predator",])
#' 
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
#' head(updated[updated$traitName %in% c( "Body_volume"),])

mutate.traitdata <- function(.data, 
                             ..., 
                             values = "traitValue", 
                             traits = "traitName", 
                             units = "traitUnit"
                             ) {
  
  traitName = NULL
  
  stopifnot(is.data.frame(.data) || is.list(.data) || is.environment(.data))
  
  in_traits <- levels(.data[,traits])
  temp <- cast.traitdata(.data, traits = traits, values = values, units = units )
  
  # extract mutations to apply into list
  out_traits <- as.list(substitute(list(...))[-1])
  out_traits <- out_traits[names(out_traits) != ""]
  
  # apply each list entry to matrix
  for (col in names(out_traits)) {
  
    temp[[col]] <- eval(out_traits[[col]], temp, parent.frame())
  }
  
  out_units <- data.frame(traitName = c(in_traits, names(out_traits)) )
  out_units$traitUnit <- sapply(as.character(out_units$traitName), function(t) {
    if("units" %in% class(temp[[t]])) {
      as.character(units(temp[[t]]))
    } else { return(NA) }
  } )
  
  class(temp) <- "data.frame"
  
  out <- suppressWarnings(reshape2::melt(temp, 
                       measure.vars = names(out_traits), 
                       id.vars = names(temp[,
                            which(!names(temp) %in% c(in_traits, names(out_traits)))]), 
                       variable_name = "traitName",
                       na.rm = TRUE
                       ) )
  
  
  names(out)[names(out) == "variable"] <- "traitName"
  names(out)[names(out) == "value"] <- "traitValue"

  out <- merge(out, out_units, by = "traitName" )
  
  out <- plyr::rbind.fill(subset(.data, !traitName %in% names(out_traits)), subset(out, traitName %in% names(out_traits))) 

    # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  attribs <- attributes(.data)
  attribs$names <- attributes(out)$names
  attribs$row.names <- seq_along(out[,1])
  attributes(out) <- attribs
  
  return(out)
}


