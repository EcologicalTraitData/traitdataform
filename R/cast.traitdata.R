#' Cast long-table trait data into wide-table format
#'
#' Function to reformat trait data from the long-table into a matrix/wide-table or occurrence table format. 
#' 
#' @param .data dataset of class 'traitdata' to be cast into wide-table format. 
#' @param summarize_num Not functional. 
#' @param summarize_cat Not functional. 
#'
#' @details The wide-table will be composed while preserving the detail given in the dataset (occurrence level or taxa level). The cells  will be filled with the values from 'traitValue'. 
#' 
#'   If taxa should be summarized, provide function for summarizing in parameter 'summarize'. This can be any function that takes a vector and returns a single value for **both numerical and factorial/character input vectors!**. The default for numerical values is to return an arithmetric mean while including any outliers.
#'    For factorial values, the value is accepted if it is equal in all of the input entries. Otherwise NA is returned. For heterogeneous factorial or character input, user action is required for homogenizing the data before calling `cast.traitdata()`. 
#' 
#' @return a wide-table data.frame object containing all taxa (and other differentiating parameters) in rows and all traits (extracted from column 'traitName') in columns.
#' 
#' @export
#'
#' @examples
#' 
#' pulldata("arthropodtraits")
#' head(arthropodtraits)
#' dataset3 <- as.traitdata(arthropodtraits,
#'                          taxa = "SpeciesID",
#'                          traits = c("Body_Size", "Dispersal_ability", "Feeding_guild","Feeding_guild_short", "Feeding_mode", "Feeding_specialization", "Feeding_tissue", "Feeding_plant_part", "Endophagous_lifestyle", "Stratum_use", "Stratum_use_short"), 
#'                          units = c(Body_Size = "mm", Dispersal_ability = "unitless"),
#'                          keep = c(measurementRemark = "Remark"),
#'                          metadata = list(license = "http://creativecommons.org/publicdomain/zero/1.0/")
#' )
#' head(dataset3)
#' head(cast.traitdata(dataset3))
#' 
#' 
#' 

cast.traitdata <- function(.data, summarize_num = mean, summarize_cat) {
  
  columns <- names(.data[,-which(names(.data) %in% c("traitName", "traitValue", "traitUnit", "measurementID"))])
  
  out <- reshape::cast(.data, eval(expression(paste(paste(columns, collapse =" + "), "~ traitName"))), value = 'traitValue') 
  
  
  
  return(out) 
}
