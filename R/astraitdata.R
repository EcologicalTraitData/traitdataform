
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
#' map1 <- list(
#' traits = list(
#'   pronotum_length = list(traitName_user = c("pronl1", "pronl2"), measurementUnit_user = "mm"),
#'   pronotum_width = list(traitName_user = c("pronw1", "pronw2"), measurementUnit_user = "mm"),     ovipositor_length = list(traitName_user = c("ov1", "ov2"), measurementUnit_user = "mm"),
#'   hind_femur_length = list(traitName_user = c("femurleft2", "femurright2", "femurleft1", "femurright1"), measurementUnit_user = "mm"),
#'   front_wing_length = list(traitName_user = c("forewingleft1", "forewingright1", "forewingleft2", "forewingright2"), measurementUnit_user = "mm")
#' ),
#' columns = list(
#'   scientificName_user = "spec",
#'   specimenID = "nr",
#'   ExploratoriesPlotID = "EP",
#'   locationID = "bz",
#'   sex = "sex",
#'   age = "age",
#'   measurementDeterminedBy = "name"
#' ), # possible to provide function instead of string?
#' template = BExIS.traitdata,
#' taxonomy = "gbif",
#' traitlist = BExIS.invertebrates,
#' matrixdata = TRUE
#' )
#' test <- as.traitdata(inputdata, mapping = map1)


as.traitdata <- function(
  input,  # takes data.frame object
  mapping = map1, # mapping object provides taxonomy, column and trait name matching
  template = BExIS.traitdata,
  metadata = list(authorName = NULL,  datasetVersion = NULL, maintainerEmail = NULL, datasetName = NULL, bibliographicCitation = NULL, identifier = NULL, rights = NULL, templateVersion = NULL, checkStatus = NULL), # a valid metadata object, will be created by a metadata function
  verbose = TRUE,
  warnings = TRUE
) {

  out <- list(
    metadata = as.list(metadata),
    mapping = mapping,
    traitdata = NA
  )

  class(out) <- c("list", "traitdata")

  # author information

  # data information

  ## which columns of input are mapped either as column or trait value?

  cols_in <-  names(inputdata)
  traitNames_user <- unlist(sapply(mapping$traits, function(x) return(x[["traitName_user"]]) ) )

  #sapply(sapply(mapping$traits, function(x) (x[["traitName_user"]]) ), function(i) rep())
  # ToDo: Add unmapped expected columns to datacolumns/to mapping
  datacolumns <- sapply(mapping$columns, function(x) return(x) )

  ismapped <- which(cols_in %in% c(traitNames_user, datacolumns ) )
  unmapped <- which(!cols_in %in% c(traitNames_user, datacolumns ) )


  # check for mandatory input columns (_user provided columns, this check differs for matrix data and table data)

  #    mandatory <- c(4,7,10,11,22) #which(as.logical(template$template$mandatory))
  #


  # warn if provided columns are not mapped
  if(warnings & length(unmapped) > 0) warning(paste("The following data columns are not mapped to standard column names and will be omitted from the dataset:", toString(cols_in[unmapped]), "! Please add columns to mapping if they should not be omitted!") )

  # warn if mapped columns are unexpected

  cols_expected <- template$template$columnName

  unexpected <- which(!names(datacolumns) %in% cols_expected)
  if( length(unexpected) > 0 ) warning(paste("The following data columns are mapped to unexpected column names!", toString(names(datacolumns)[unexpected])," Unexpected columns will be kept for your personal use. Please double-check for misspelled column names!"))

  #out <- t(data.frame( row.names = template$template$columnName))


  # check for species names and provide accepted species name table (via taxize?)

  scientificNames_user <- levels(input[,datacolumns[names(datacolumns) == "scientificName_user"]])

  # resolve synonyms to accepted names

  get_gbif_taxonomy(scientificNames_user)


  # get GBIF ID as taxonID

  synonyms

  gbifid <- get_gbifid_(matching_table$matched_name2)
  lapply(gbifid, function(x) subset(x, synonym == FALSE))

  #  cols_expected[mandatory] %in% names(datacolumns)


  # check for matrix format, return warning if not sure
  # check if trait names are in column names
  # check if trait names are in rows

  if(mapping$matrixdata == TRUE)

    # get user data

    temp <- lapply(traitNames_user, FUN = function(i) {

      out <- input[!is.na(input[,as.character(i)]), names(input) %in% datacolumns]
      names(out) <- names(mapping$columns)[match(names(out), mapping$columns)]
      out$traitName_user <- i
      out$measurementValue_user <- na.exclude(input[,as.character(i)])
      # if length(measurementUnit_user) == length(traitName_user) map trait units here, elseif length(measurementUnit_user) == 1 do it later on the accepted trait level
      return(out)
    }  )

  names(temp) <- unique(traitNames_user)

  # merge list entries by same accepted trait ID, concatenate traittable information

  out$traitdata <- lapply(names(mapping$traits), FUN = function(i) {

    out <- data.table::rbindlist(temp[mapping$traits[[i]]$traitName_user])  # use faster data.table::rbindlist(data) instead?
    out$traitName <- i
    out <- merge(out, mapping$traitlist$thesaurus[,c("traitName", "measurementUnit", "traitClass","traitType", "traitID")], by = "traitName")
    # test for correct type of value (categorical, ordinal, numerical, binary, integer, as expected by traitlist)


    # test for trait unit match, and match in factor levels


    # stop if false: try perform unit conversion or request valid factor levels
    # https://edzer.github.io/units/articles/measurement_units_in_R.html

    return(out)
  }
  )
  rm(temp)
  names(out$traitdata) <- names(mapping$traits)


  return(out)
}


write.traitdata <- function(x, file, ... ) {

  printobject <- list(template = read.table(text = "",
                                            #colClasses = template$template$valueType,
                                            col.names = template$template$columnName) #ToDo. extract from metadata
  )

  for(i in 1:length(x$traitdata)) {
    printobject[[i+1]] <- x$traitdata[[i]]
  }

  write.csv(data.table::rbindlist(printobject, fill = TRUE), file = file, row.names = FALSE, ...)
  # write metadata objects
}
