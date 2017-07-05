#' Title
#'
#' @param input
#' @param mapping
#' @param template
#' @param metadata
#' @param verbose
#' @param warnings
#'
#' @return
#' @export
#'
#' @examples
#'
#' inputdata <- read.csv("../example_data/Orthoptera_MelanieChiste_flucAssym.csv")
#'
#' map1 <- traitmap(
#'   pronotum_length = list(measurementType_original = c("pronl1", "pronl2"), measurementUnit_original = "mm", basisOfRecord = "PreservedSpecimen", basisOfRecordDescription = "dry sample"),
#'   pronotum_width = list(measurementType_original = c("pronw1", "pronw2"), measurementUnit_original = "mm", basisOfRecord = "PreservedSpecimen", basisOfRecordDescription = "dry sample"),     
#'   ovipositor_length = list(measurementType_original = c("ov1", "ov2"), measurementUnit_original = "mm", basisOfRecord = "PreservedSpecimen", basisOfRecordDescription = "dry sample"),
#'   hind_femur_length = list(measurementType_original = c("femurleft2", "femurright2", "femurleft1", "femurright1"),  measurementUnit_original = "mm", basisOfRecord = "PreservedSpecimen", basisOfRecordDescription = "dry sample"),
#'   front_wing_length = list(measurementType_original = c("forewingleft1", "forewingright1", "forewingleft2", "forewingright2"), measurementUnit_original = "mm", basisOfRecord = "PreservedSpecimen", basisOfRecordDescription = "dry sample")
#'   )
#'    
#' test <- as.traitdata(input = rename(inputdata, ### ),
#'    traits = traitlist(traits = map2, thesaurus = BExIS.invertebrates$thesaurus)
#'    )


as.traitdata <- function(
  input,  # takes data.frame object
  traits = NULL, # mapping object provides taxonomy, column and trait name matching
  metadata = c(authorName = NULL,  datasetVersion = NULL, maintainerEmail = NULL, datasetName = NULL, bibliographicCitation = NULL, identifier = NULL, rights = NULL, templateVersion = NULL, checkStatus = NULL), # a valid metadata object, will be created by a metadata function
  verbose = TRUE
) {
  # check if metadata use compatible fields
  
  out <- list(
    metadata = as.list(metadata),
    traitdata = NA,
    specieslist = NA,
    traitlist = NA,
    occurence = NA,
    measurementOrFact = NA
  )

  class(out) <- c("list", "traitdata")

  # author information

  # data information

  
  # check if input uses expected column names (core traitdata standard)
  
  # check if traitlist is compatible with input
  

  ## which columns of input are mapped either as column or trait value?

  cols_input <-  names(inputdata)
  
  if(any(cols_input %in% traits$measurementType_original)) type_of_dataset <- "matrix"
  
  traitNames_mapped <- cols_input[cols_input %in% traits$measurementType_original]

  ####### TODO ####
  # - mode for matching multiples to accepted trait names
  # - think about non-matrix data
  # - function to get trait matching table for this particular traitset (analogue to species taxonomy)

  #sapply(sapply(mapping$traits, function(x) (x[["traitName_user"]]) ), function(i) rep())
  # ToDo: Automatically add unmapped expected columns to datacolumns/to mapping
  
  # toDo: check entry columns for matching to expected names from template
  # datacolumns <- sapply(mapping$columnmap, function(x) return(x) )

  #ismapped <- which(cols_input %in% c(traits$measurementType_original, datacolumns ) )
  #unmapped <- which(!cols_input %in% c(traitNames_user, datacolumns ) )

  # warn if provided columns are not mapped
  #if(verbose & length(unmapped) > 0) warning(paste("The following data columns are not mapped to standard column names and will be omitted from the dataset:", toString(cols_in[unmapped]), "! Please add columns to mapping if they should not be omitted!") )

  # warn if mapped columns are unexpected
  #cols_expected <- template$columns

  #unexpected <- which(!names(datacolumns) %in% cols_expected)
  #if(verbose & length(unexpected) > 0 ) warning(paste("The following data columns are mapped to unexpected column names!", toString(names(datacolumns)[unexpected])," Unexpected columns will be kept for your personal use. Please double-check for misspelled column names!"))


  # check for mandatory input columns (_user provided columns, this check differs for matrix data and table data)

  #    mandatory <- c(4,7,10,11,22) #which(as.logical(template$template$mandatory))
  #
  #  cols_expected[mandatory] %in% names(datacolumns)


  # check for species names and provide accepted species name table (via taxize?)

  if("scientificName_original" %in% names(datacolumns)) {

    if(!"taxonomy" %in% class(mapping$taxonomy)  ) {
      mapping$taxonomy <- switch(mapping$taxonomy,
                                 gbif = get_gbif_taxonomy(levels(input[,datacolumns[which("scientificName_user" %in% names(datacolumns))]]) ),
                                 eol = stop("no valid taxonomy provided!")
      )
    }

    input$scientificName <- input[,datacolumns[which("scientificName_user" %in% names(datacolumns))]]

    levels(input$scientificName) <- mapping$taxonomy$scientificName

    matchvec <- match(input$scientificName, mapping$taxonomy$scientificName)

    input$taxonID <- paste0(mapping$taxonomy$taxonomy, "::", mapping$taxonomy$taxonID)[matchvec]
    input$taxonRank <- mapping$taxonomy$rank[matchvec]
    input$warnings  <- c(NA, paste("User provided synonym!"))[mapping$taxonomy$synonym[matchvec]+1]
    datacolumns <- c(datacolumns, taxonID = "taxonID", scientificName = "scientificName", taxonRank = "taxonRank", warnings = "warnings")

  } else {
    stop("The column 'scientificName_user' has not been provided or has not been mapped! please provide a column with species names and map it to this mandatory column name!")
  }


  #



  # check for matrix format, return warning if not sure
  # check if trait names are in column names
  # check if trait names are in rows

  if(mapping$matrixdata == TRUE)

    # get user data

    out$traitdata <- lapply(traitNames_user, FUN = function(i) {

      temp1 <- input[!is.na(input[,as.character(i)]), names(input) %in% datacolumns]
      names(temp1) <- names(datacolumns)[match(names(temp1), datacolumns)]
      temp1$traitName_user <- i
      temp1$measurementValue_user <- na.exclude(input[,as.character(i)])

      # concatenate traittable information
      i_maps_to <- traitlookup[traitlookup$traitName_user == i,]$traitName
      furthercols <-  unique(c(names(mapping$traitmap[[i_maps_to]]), names(mapping$appliestoall)))
      furthercols <- furthercols[furthercols != "traitName_user"]

      temp1 <- merge(temp1, traitlookup[,c("measurementUnit", "traitName", "traitID", "traitName_user", furthercols), with = FALSE], by = "traitName_user")

      # TEST: if trait is not provided in the thesaurus skip next steps!
      if(!is.na(traitlookup[traitlookup$traitName_user == i,]$traitID))  {

        # validate type of data
        type <- as.character(traitlookup[traitlookup$traitName_user == i,]$type_of_value)

        if(!type %in% c("factor", "logical", "numeric", "integer", "character")) stop("the traitlist must provide a valid data type in column 'type_of_value'! make sure it is one of:  'factor', 'logical', 'numeric', 'integer', 'character'" )

        temp1$measurementValue_user <- switch(type,
                          numeric = as.numeric(temp1$measurementValue_user),
                          factor = as.factor(temp1$measurementValue_user),
                          logical = as.logical(temp1$measurementValue_user),
                          character = as.character(temp1$measurementValue_user),
                          integer = as.integer(temp1$measurementValue_user)
        )

        if(type == "numeric") {
          unit_user <- as.character(traitlookup[traitlookup$traitName_user == i,]$measurementUnit_user)
          unit_target <- as.character(traitlookup[traitlookup$traitName_user == i,]$measurementUnit)

          dd_user <- temp1$measurementValue_user * ud_units[[unit_user]]

          temp1$measurementValue <- set_units(dd_user, parse_unit(unit_target))

        }
        if(type == "factor") {
          factorLevels <- as.character(traitlookup[traitlookup$traitName_user == i,]$factorLevels)
          level_map <- as.data.frame(mapping$traitmap[[i_maps_to]]) # get valid factor levels map from mapping object
          levels_user <- levels(temp1$measurementValue_user)
        }


      }


      return(temp1)
    }  )

  names(out$traitdata) <- traitNames_user

  # merge list entries by same accepted trait ID

  out$traitdata <- lapply(names(mapping$traitmap), FUN = function(i) {

    temp2 <- data.table::rbindlist(out$traitdata[mapping$traitmap[[i]]$traitName_user])  # use faster data.table::rbindlist(data) instead?

    return(temp2)
  }
  )

  names(out$traitdata) <- names(mapping$traits)


  return(out)
}


write.traitdata <- function(x, file, ... ) {

  printobject <- list(template = read.table(text = "",
                                            #colClasses = template$template$valueType,
                                            col.names = template$columns) #ToDo. extract from metadata
  )

  for(i in 1:length(x$traitdata)) {
    printobject[[i+1]] <- x$traitdata[[i]]
  }

  write.csv(data.table::rbindlist(printobject, fill = TRUE), file = file, row.names = FALSE, ...)
  # write metadata objects
}

#as.matrix.traitdata <- function( ) # function to compile trait data tables into matrix format. This requires many user options, e.g. adding filters and check for outliers, averaging method etc. a conservative scenario will be provided as default.

#summary.traitdata <- function( ) # summary method for traitdata objects

#print.traitdata <- function( ) ## print method for traitdata objects, prints short header of metadata and stats (number of traits, species etc.) and top 30 of rows (minus some hidden columns for clarity)
