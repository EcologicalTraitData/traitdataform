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
#' @import data.table
#'  
#' @examples
#' 
#' data(carabids)
#' 
#' dataset1 <- as.traitdata(carabids, 
#'   taxa = "name_correct", 
#'   traits = c("body_length", "antenna_length", "metafemur_length"),
#'   units = "mm",
#'   keep = c(datasetID = "source_measurement", measurementRemark = "note"), 
#'   metadata = list(
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
#' dataset1Std <- standardize(dataset1, thesaurus = traits1)
#' 
#' # occurrence table: 
#' 
#' data(heteroptera_raw)
#' 
#' dataset2 <- as.traitdata(heteroptera_raw, 
#'   taxa = "SpeciesID", 
#'   traits = c("Body_length", "Antenna_Seg1", "Antenna_Seg2",
#'     "Antenna_Seg3", "Antenna_Seg4", "Antenna_Seg5", "Hind.Femur_length"),
#'   units = "mm", 
#'   keep = c(sex = "Sex", references = "Source", lifestage = "Wing_development"),
#'   metadata = list(
#'     bibliographicCitation = attributes(heteroptera_raw)$citeAs, 
#'     license = "http://creativecommons.org/publicdomain/zero/1.0/"
#'     )
#' )
#' 
#'dataset2 <- mutate.traitdata(dataset2, antenna_length = Antenna_Seg1 + Antenna_Seg2 + Antenna_Seg3 + Antenna_Seg4 + Antenna_Seg3 )
#' 
#' 
#' traits2 <- as.thesaurus(
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
#' dataset2Std <- standardize(dataset2, 
#'     thesaurus = traits2, 
#'     rename = c(Body_length = "body_length", 
#'                antenna_length = "antenna_length", 
#'                Hind.Femur_length = "metafemur_length"
#'                )
#'     )
#' 
#' database <- rbind.traitdata(dataset1Std, dataset2Std)

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
  names(input) <- input_names
  
  
  # set datasetID according to parameter datasetID
  if(!is.null(datasetID) && length(datasetID) == length(input) ) {
    for(i in 1:length(input)) {
      attributes(input[[i]])$datasetID <- datasetID[i]
      input[[i]]$datasetID <- input_names[i]
      }
  }  
  
  # set datasetID according to metadata entry names
  if(is.null(datasetID) && !is.null(names(metadata)) && length(metadata) == length(input)) {
    for(i in 1:length(input)) {
      attributes(input[[i]])$datasetID <- names(metadata)[i]
      input[[i]]$datasetID <- input_names[i]
      }
  }  
  
  # set datasetID according to object names
  if(is.null(datasetID) && is.null(metadata) && 
       is.null(unlist(lapply(input, function(x) attributes(x)$datasetID)))) {
    for(i in 1:length(input)) {
      attributes(input[[i]])$datasetID <- input_names[i]
      input[[i]]$datasetID <- input_names[i]
      }
  }  
  
  
  ##### make metadata lookup table
  
  metacolumns <- c("rightsHolder", 
                   "bibliographicCitation",
                   "license", 
                   "datasetID",
                   "datasetName" , 
                   "author", 
                   "version"
                   )
  
  metadata <- lapply(input, function(x) {
        out <- attributes(x)[metacolumns]
        names(out) <- metacolumns
        out[sapply(out, is.null)] <- NA
        class(out) <- c("metadata", "list")
        return(out)
        } 
    )
  names(metadata) <- input_names
  
  attr_table <- do.call(rbind.data.frame, lapply(metadata, function(x) lapply(x, as.character)))[,c("datasetID", "datasetName", "author")]
  
  ##### check for compatibility of used terms in datasets
  
  terms_used <- lapply(input, colnames)
  
  traits_standardized <- sapply(terms_used, function(x) c("traitNameStd") %in% x ) 
  taxa_standardized <- sapply(terms_used, function(x) c("ScientificNameStd") %in% x ) 
  
  # # assign dataset ID 
  # if(is.null(datasetID)) { datasetID <- input_names } else {
  #   if(length(datasetID) != length(input)) stop("parameter 'datasetID' must be of same length as the number of input objects.")
  # }
  # for(x in 1:length(input)) input[[x]]$datasetID <- as.factor(datasetID[x])
  
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
  
  out <- data.table::rbindlist(input, use.names = TRUE, fill = !drop)
  
  out <- as.data.frame(out)
  
  # match metadata attributes according to datasetID
  
  out <- merge(out, attr_table, by = "datasetID")
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  # maintain attributes
  attribs <- attributes(..1)
  attribs$names <- attributes(out)$names
  attribs$row.names <- seq_along(out[,1])

  attr(out, "metadata") <- metadata
  
  attributes(out) <- attribs
  
  return(out)
}
  