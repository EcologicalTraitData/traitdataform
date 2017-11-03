
#'Combine trait datasets
#'
#'@description Function to append objects of class 'traitdata' to each other. 
#'
#'@param ... two or more objects of class traitdata.
#'@param metadata a list of metadata entries which are to be added as
#'  dataset-level information.
#'@param datasetID a vector of the same length as number of objects. If `NULL`
#'  (default), object names will be returned as ID.
#'  
#'@return
#'@export
#'@import data.table
#'  
#' @examples
#' 
#' library(traitdataform)
#' data(carabids, arthropodtraits)
#' 
#' dataset1 <- as.traitdata(carabids, 
#'                         taxa = "name_correct",
#'                         traits = c("body_length", 
#'                                    "antenna_length", 
#'                                    "metafemur_length", 
#'                                    "eyewidth_corr")
#')
#' 
#' dataset2 <- as.traitdata(heteroptera,
#' taxa = "SpeciesID",
#' traits = c("Body_length", "Body_volume", "Rel_wing_length", 
#'    "Hind.Femur_shape", "Rel_Hind.Femur_length", 
#'    "Rel_Rostrum_length", "Front.Femur_shape", 
#'    "Body_shape", "Rel_eye_size", "Rel_Antenna_length"
#'    ), 
#' units = c(Body_length = "mm", Body_volume = "mm^3")
#' )
#' 
#' newdata <- rbind(dataset1, dataset2, 
#'                datasetID = c("carabids", "heteroptera")
#'              )

rbind.traitdata <- function(..., 
                            metadata = NULL, 
                            datasetID = NULL,
                            drop = NULL # drop columns that are not present in all datasets
) {
  
  input_names <- deparse(substitute(x(...))) 
  input_names <- strsplit(gsub("[)]", "", gsub("[x(]", "", gsub( " ", "", input_names))), "[,]")[[1]]
  input_names <- as.factor(input_names)
  
  input <- list(...)
  
  terms_used <- lapply(input, colnames)
  
  traits_standardized <- sapply(terms_used, function(x) c("traitNameStd") %in% x ) 
  taxa_standardized <- sapply(terms_used, function(x) c("ScientificNameStd") %in% x ) 
  
  # assign dataset ID 
  if(is.null(datasetID)) { datasetID <- input_names } else {
    if(length(datasetID) != length(input)) stop("parameter 'datasetID' must be of same length as the number of input objects.")
  }
  for(x in 1:length(input)) input[[x]]$datasetID <- as.factor(datasetID[x])
  
  # Check if trait names are compatible
  traits <- lapply(input, function(x) levels(x$traitName))
  if(all(traits_standardized)) { traitsStd <- lapply(input, function(x) levels(x$traitNameStd)) } else { traitsStd <- NA }
  
  if(length(unlist(traits)) == length(unique(unlist(traits))) && length(unlist(traitsStd)) == length(unique(unlist(traitsStd)))) {
   warning("There seems to be no overlap in trait names of the provided datasets. 
           It is recommended to map 'traitNameStd' of each dataset to the same thesaurus or ontology!")
  }
  
  # check if taxon names are compatible
  taxa <- lapply(input, function(x) levels(x$ScientificName))
  if(all(taxa_standardized) ) {taxaStd <- lapply(input, function(x) levels(x$ScientificNameStd)) } else { taxaStd <- NA }
  
  if(length(unlist(taxa)) == length(unique(unlist(taxa))) && length(unlist(taxaStd)) == length(unique(unlist(taxaStd))) )  {
    warning("There seems to be no overlap in taxon names of the provided datasets. 
            It is recommended to map 'ScientificNameStd' of each dataset to the same thesaurus or ontology!")
  }
  
  input <- lapply(input, data.table::as.data.table)
  
  out <- data.table::rbindlist(input, use.names = TRUE, fill = TRUE)
  
  out <- as.data.frame(out)
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  
}
  