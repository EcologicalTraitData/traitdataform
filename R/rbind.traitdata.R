#' Combine trait datasets
#'
#' Method for function `rbind()` to append objects of class 'traitdata' to each 
#' other.
#'
#' @param ... two or more objects of class traitdata.
#' @param metadata a list of metadata entries which are to be added as 
#'   dataset-level information.
#' @param datasetID a vector of the same length as number of objects. If `NULL` 
#'   (default), object names will be returned as ID.
#' @param drop FALSE by default. If true, columns that are not present in all
#'   datasets will be dropped.
#'  
#' @details Metadata are ideally already included in the datasets as attributes 
#'   (see `?as.traitdata`). The function `rbind.traitdata()` takes a list of 
#'   lists as its  metadata argument. The outer list must have the same length as
#'   the provided objects to combine, with each entry containing objects 
#'   according to the terms of the Ecological Traitdata Standard 
#'   (http://ecologicaltraitdata.github.io/ETS/#metadata-vocabulary).
#'  
#'   A lookup table for dataset details will be appended as an attribute to the 
#'   output dataset, linked to each entry via the field `datasetID`. It can be
#'   accessed by calling `attributes(<dataset>)$datasets`.
#'  
#' @export
#' @importFrom data.table rbindlist as.data.table
#'  
#' @examples
#' 
#' pulldata("carabids")
#' 
#' dataset1 <- as.traitdata(carabids, 
#'   taxa = "name_correct", 
#'   traits = c("body_length", "antenna_length", "metafemur_length"),
#'   units = "mm",
#'   keep = c(datasetID = "source_measurement", measurementRemarks = "note"), 
#'   metadata = as.metadata(
#'     bibliographicCitation = attributes(carabids)$citeAs,
#'     author = "Fons van der Plas", 
#'     license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'     )
#' )
#' 
#' 
#' traits1 <- as.thesaurus(
#'  body_length = as.trait("body_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"), 
#'  antenna_length = as.trait("antenna_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Antenna_length"),
#'  metafemur_length = as.trait("metafemur_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
#')
#'
#' dataset1Std <- standardize.traits(dataset1, thesaurus = traits1)
#' 
#' # occurrence table: 
#' 
#' pulldata("heteroptera_raw")
#' 
#' dataset2 <- as.traitdata(heteroptera_raw, 
#'   taxa = "SpeciesID", 
#'   traits = c("Body_length", "Antenna_Seg1", "Antenna_Seg2",
#'     "Antenna_Seg3", "Antenna_Seg4", "Antenna_Seg5", "Hind.Femur_length"),
#'   units = "mm", 
#'   keep = c(sex = "Sex", references = "Source", lifeStage = "Wing_development"),
#'   metadata = as.metadata(
#'     bibliographicCitation = attributes(heteroptera_raw)$citeAs, 
#'     author = "Martin Gossner",
#'     license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'     )
#' )
#' 
#'dataset2 <- mutate.traitdata(dataset2, 
#'   antenna_length = Antenna_Seg1 + Antenna_Seg2 + Antenna_Seg3 + Antenna_Seg4 + Antenna_Seg5 
#'   )
#' 
#' 
#' traits2 <- as.thesaurus(
#'  Body_length = as.trait("body_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"), 
#'  antenna_length = as.trait("antenna_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Antenna_length"),
#'  Hind.Femur_length = as.trait("metafemur_length", 
#'    expectedUnit = "mm", valueType = "numeric", 
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
#')
#'
#' dataset2Std <- standardize_traits(dataset2, thesaurus = traits2)
#' 
#' database <- rbind(dataset1Std, dataset2Std)

rbind.traitdata <- function(..., 
                            metadata = NULL, 
                            datasetID = NULL,
                            drop = NULL # drop columns that are not present in all datasets
) {
  
  # extract object names of input
  input_names <- deparse(substitute(x(...))) 
  input_names <- strsplit(gsub("[)]", "", gsub("[x(]", "", gsub( " ", "", input_names))), "[,]")[[1]]
  input_names <- as.factor(input_names)
  
  # compose list of input objects
  input <- list(...)
  
  metadata <- lapply(input, function(x) attributes(x)$metadata)
  has_metadata <- sapply(input, function(x) !is.null(attributes(x)$metadata))
  has_id <- sapply(input, function(x) !is.null(attributes(x)$metadata$datasetID))
  
  #add datasetID value as column in core data,
    for(i in 1:length(metadata)) {
      #  get datasetID from metadata, provided vector, or object names (in that order) 
      if(is.null(metadata[[i]]$datasetID)) {
        if(!is.null(datasetID) && length(datasetID) == length(input)) {
          metadata[[i]]$datasetID <- datasetID[i]
        } else {
          metadata[[i]]$datasetID <- input_names[[i]]
        }
      }
      input[[i]]$datasetID <- metadata[[i]]$datasetID
    }
  names(metadata) <- sapply(metadata, function(x) x$datasetID)
  names(input) <- sapply(metadata, function(x) x$datasetID)
  
  ##### make metadata lookup table

  attr_table <- do.call(rbind.data.frame, lapply(metadata, function(x) lapply(x[c("datasetID", "datasetName", "author")], function(y) if(is.null(y)) "NA" else y )))

  ##### check for compatibility of used terms in datasets
  
  terms_used <- lapply(input, colnames)
  
  traits_standardized <- sapply(terms_used, function(x) c("traitNameStd") %in% x ) 
  taxa_standardized <- sapply(terms_used, function(x) c("ScientificNameStd") %in% x ) 
  
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
  
  
  # rbind data objects in input list
  input <- lapply(input, data.table::as.data.table)
  
  out <- data.table::rbindlist(input, use.names = TRUE, fill = TRUE)
  
  out <- as.data.frame(out)
  
  # match metadata attributes according to datasetID
  
  out <- merge(out, attr_table, by = "datasetID")
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  # maintain attributes
  attribs <- attributes(..1)
  attribs$names <- attributes(out)$names
  attribs$row.names <- seq_along(out[,1])

  attributes(out) <- attribs
  attr(out, "metadata") <- metadata
  
  return(out)
}
  