#' BExIS access over a Webservice 
#' 
#' Read table from a web service. Inherits functionality of `read.table()`.
#'
#' @param datasetid Integer BExIS ID of the requested dataset. 
#' @param user User name on BExIS. If not provided, function will prompt input. 
#' @param pswd Password on BExIS. If not provided, function will prompt input. 
#' @param dec the character used in the file for decimal points.
#' @param na.strings a character vector of strings which are to be interpreted as NA values. Blank fields are also considered to be missing values in logical, integer, numeric and complex fields.
#' @param fill logical. If TRUE then in case the rows have unequal length, blank fields are implicitly added. See 'Details' of `?read.table`.
#' @param sep the field separator character. Values on each line of the file are separated by this character. If sep = "" (the default for read.table) the separator is 'white space', that is one or more spaces, tabs, newlines or carriage returns.
#' @param quote the set of quoting characters. To disable quoting altogether, use quote = "". See scan for the behaviour on quotes embedded in quotes. Quoting is only considered for columns read as character, which is all of them unless colClasses is specified.
#' @param fileEncoding character string: if non-empty declares the encoding to be used on a file (not a connection) so the character data can be re-encoded as they are written. See [base::connections()].
#' 
#' @author Dennis Heimann, Andreas Ostrowski
#'
#' @return Returns dataset from BExIS as a data.frame.
#'
#' @details `read.service.blocks()` returns a data.frame array as a list of data.frames.
#' 
#' @import XML
#' @import RCurl
#' @import getPass
#' @keywords internal
#' 


read.service <- function(datasetid, 
                         user = NULL, pswd = NULL, 
                         dec=".", 
                         na.strings="NA", 
                         fill=FALSE, sep="\t", 
                         quote=if(identical(sep, "\n")) "" else "'\"",
                         fileEncoding = "UTF-8")
{
  
  if(is.null(user)) user <- readline("user name: ") 
  if(is.null(pswd)) pswd <- getPass::getPass("password: ", noblank = FALSE)
  
  
  opts = curlOptions(encoding="CE_UTF8" ,ssl.verifypeer = FALSE, httpheader=c(Accept = "text/plain"))
  params = c("datasetId"=datasetid, "username"=user, "password"=pswd)
  data <- postForm(uri="https://www.bexis.uni-jena.de/WebServices/DataService.asmx/DownloadData", .params=params, .opts=opts, style="post")  
  x <- xmlTreeParse(data, asText = T, trim=FALSE)
  txt <- xmlValue(xmlRoot(x)[[1]])
  txt <-gsub("#","?", txt)
  f <- textConnection(toString(txt))   
  d <- utils::read.table(file=f, sep=sep, header=T, dec=dec, na.strings=na.strings, fill=fill, quote=quote, fileEncoding = fileEncoding)
  close(f)
  d
}

#----------------------------------------------------------
#---- Read table with blocks from a web service -----------
#---- returns a data.frame array                      -----------
#----------------------------------------------------------

#' @rdname read.service
#' @keywords internal

read.service.blocks <- function(datasetid, 
                                user, pswd, 
                                dec=".", 
                                na.strings="NA", 
                                fill=FALSE, 
                                sep="\t", 
                                quote=if(identical(sep, "\n")) "" else "'\"", 
                                fileEncoding = "UTF-8")
{  
  
  if(is.null(user)) user <- readline("user name: ") 
  if(is.null(pswd)) pswd <- getPass::getPass("password: ", noblank = FALSE)
  
  opts = curlOptions(encoding="CE_LATIN1" ,ssl.verifypeer = FALSE, httpheader=c(Accept = "application/x-zip-compressed"))
  params = c("datasetId"=datasetid, "username"=user, "password"=pswd, "includeMetadata"="false")
  zip <- postForm(uri="https://www.bexis.uni-jena.de/WebServices/DataService.asmx/DownloadDataText", .params=params, .opts=opts, style="post", binary=TRUE)
  x <- xmlTreeParse(zip, trim=FALSE, asText=T)
  bin <- xmlValue(xmlRoot(x)[[1]])
  b <- base64Decode(bin, "raw")
  f <- tempfile()
  writeBin(b, con=f)
  ex <- utils::unzip(f, exdir = tempdir())
  files <- attr(ex, "extracted", TRUE)
  soil <- lapply(files, utils::read.table, sep=sep, header=T, dec=dec, na.strings=na.strings, fill=fill, quote=quote, fileEncoding = fileEncoding)
}


#' Standardise logical variables
#'
#' @param x a vector of two different types of entries (can be of type factor, integer, logical, or character).
#' @param output a switch to set the desired output format. Defaults to "logical", but can be "character", "binary" or "factor".  
#' @param categories output target categories for binary/logical traits harmonization if `output` is not set to 'logical'.
#'
#' @keywords internal
#' @return A vector of harmonized logical values.
#'

fixlogical <- function(x, output = "logical", categories = c("No", "Yes")) {
  
  x <- factor(tolower(x))
  
  # ToDo: add test or fuzzy matching algorithm
  
  levels(x) <- list('0'=c("0", "no", "n", "nein", "false", "non"),
                    '1'=c("1", "yes", "y", "ja",  "j", "true", "oui", "si"))
  
  levels(x) <- categories
  
  x <- switch(output,
              factor = x,
              character = as.character(x),
              binary = as.numeric(x)-1,
              logical = as.logical(as.numeric(x)-1)
  )
  return(x)
}



#' Check if string is valid unit
#'  
#' @param x ds
#' @noRd
#' @keywords internal

is_unit <- function(x) { 
  !c("simpleError") %in% class(tryCatch(as_units(x), error  = function(e) e))
}



#' Locale-independent factor conversion
#'
#' @param x a vector 
#' 
#' @keywords internal
#' @return the same vector, but with any factorial content or colums with repeating character strings converted to factors, applying a locale-independent sorting. 
#' @note Only for internal application in [as.traitdata()] This deals with the problem described by Kurt Hornik [(here)](https://developer.r-project.org/Blog/public/2020/02/16/stringsasfactors/index.html) for changes coming in R 4.0.0. In traitdataform, this concerns the locale-dependence of taxon and trait name sorting when calling published trait-datasets. For traits, the sorting order of factor levels will be superimposed by the order given in the thesaurus specification (if provided).

as_factor_clocale <- function(x) {
      lc_collate <- Sys.getlocale("LC_COLLATE") 
      Sys.setlocale("LC_COLLATE", "C")
      x <- factor(as.character(x)) 
      Sys.setlocale("LC_COLLATE", lc_collate)
  return(x)      
}


#' Convert output to ETS v0.9
#'   
#' @noRd
#' @import stats
#' @keywords internal

convert.ets0.9 <- function(x) {
  if(attr(x, "metadata")$conformsTo == "Ecological Trait-data Standard (ETS) v0.10") {
    
    oldnames <- c("scientificName", "verbatimScientificName", "traitName", "verbatimTraitName", "traitUnit", "verbatimTraitUnit", "traitValue", "verbatimTraitValue")
    newnames <- c("scientificNameStd", "scientificName", "traitNameStd", "traitName", "traitUnitStd", "traitUnit", "traitValueStd", "traitValue")
    
    colnames(x)[names(x) %in% oldnames] <- na.omit(newnames[match(names(x), oldnames)])

    attr(x, "metadata")$conformsTo <- "Ecological Trait-data Standard (ETS) v0.9"
    
  } 
  return(x)
} 
