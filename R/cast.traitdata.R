#' Cast long-table trait data into wide-table format
#'
#' Function to reformat trait data from the long-table into a matrix/wide-table
#' or occurrence table format.
#'
#' @param .data dataset of class 'traitdata' to be cast into wide-table format.
#' @param traits the column name to be kept for parsing into wide-table (default
#'   is `traitName`). Note that any duplicate column that contains trait names,
#'   e.g. `traitNameStd` will be omitted.
#' @param units the column name containing the units of numerical values
#'   (default is `traitUnit`).
#' @param values the column name containing the trait values to be used to fill
#'   the matrix (default is `traitValue`). Duplicate columns (e.g.
#'   `traitValueStd`) will be omitted. See notes.
#' @param fun.aggregate option for [reshape2::dcast()] to define method of
#'   aggregation.
#'
#' @details The wide-table will be composed while preserving the detail given in
#'   the dataset (occurrence level or taxa level). The cells  will be filled
#'   with the values from 'traitValue'.
#'
#'   If taxa should be summarized, provide function for summarizing in parameter
#'   'summarize'. This can be any function that takes a vector and returns a
#'   single value for **both numerical and factorial/character input vectors!**.
#'   The default for numerical values is to return an arithmetric mean while
#'   including any outliers. For factorial values, the value is accepted if it
#'   is equal in all of the input entries. Otherwise NA is returned. For
#'   heterogeneous factorial or character input, user action is required for
#'   homogenizing the data before calling `cast.traitdata()`.
#'
#' @section Duplicate columns: The function is currently not able to handle
#'   multiple columns of trait data (incl. names and units). Those are currently
#'   omitted from the output and may be added manually. You can alter the
#'   columns to be used to construct the matrix by specifying those in
#'   parameters `traits`, `values`, and `units`. Automatic handling of the `Std`
#'   columns might be added at a later stage.
#'
#' @return a wide-table data.frame object containing all taxa (and other
#'   differentiating parameters) in rows and all traits (extracted from column
#'   'traitName') in columns.
#'
#' @export
#' @importFrom reshape2 dcast
#' @import units
#'
#' @examples
#'
#' pulldata("arthropodtraits")
#' head(arthropodtraits)
#' dataset3 <- as.traitdata(arthropodtraits,
#'                          taxa = "SpeciesID",
#'                          traits = c("Body_Size", "Dispersal_ability",
#'                                "Feeding_guild","Feeding_guild_short",
#'                                "Feeding_mode", "Feeding_specialization",
#'                                "Feeding_tissue", "Feeding_plant_part",
#'                                "Endophagous_lifestyle", "Stratum_use",
#'                                "Stratum_use_short"),
#'                          units = c(Body_Size = "mm"),
#'                          keep = c(measurementRemark = "Remark"),
#'                          metadata = as.metadata(
#'                             license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'                             )
#' )
#'
#' head(dataset3)
#'
#' dd3 <-cast.traitdata(dataset3)
#' head(dd3)
#'
#' 

cast.traitdata <- function(.data, 
                           values = "traitValue", 
                           traits = "traitName", 
                           units = "traitUnit", 
                           fun.aggregate = NULL
                           ) {
  
  columns <- names(.data[,-which(names(.data) %in% c(traits, values, units, "measurementID"))])
  
  # Extract units of numerical traits
  if(units %in% names(.data)) unit_list <- split(.data[,c(units)], f = .data[,traits])
  
  # out <- reshape::cast(.data, eval(expression(paste(paste(columns, collapse =" + "), "~", traits))), 
  #                      value = values,
  #                      fun.aggregate = fun.aggregate,
  #                      fill = NA
  #                      ) 
  
  out <- reshape2::dcast(.data, eval(expression(paste(paste(columns, collapse =" + "), "~", traits))), 
               value.var = values,
               fun.aggregate = fun.aggregate,
               fill = NA)
  
  if(units %in% names(.data)) {
    for(i in levels(.data[,traits])) {
      
      if(length(unique(unit_list[[i]])) == 1 )  {
        unit_list[[i]] <- as.character(unique(unit_list[[i]]))
      } else {
        unit_list[[i]] <- as.character(unit_list[[i]])
      }
      
      if(all(sapply(unit_list[[i]] , is_unit))) {
        out[,i] <- as.numeric(as.character(out[,i])) * units::as_units(unit_list[[i]])
      } else {
        if(!all(is.na(unit_list[[i]]))) {
          message(paste0("Provided unit for '", names(unit_list[i]), "' is not recognised and will be dropped!"))
        }
      }
      
    }
  }

  
  
  return(out) 
}
