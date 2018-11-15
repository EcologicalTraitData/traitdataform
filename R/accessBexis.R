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
#' @param sep the field separator character. Values on each line of the file are separated by this character. If sep = "" (the default for read.table) the separator is ‘white space’, that is one or more spaces, tabs, newlines or carriage returns.
#' @param quote the set of quoting characters. To disable quoting altogether, use quote = "". See scan for the behaviour on quotes embedded in quotes. Quoting is only considered for columns read as character, which is all of them unless colClasses is specified.
#' @param fileEncoding character string: if non-empty declares the encoding to be used on a file (not a connection) so the character data can be re-encoded as they are written. See [base::file()].
#' 
#' @author Dennis Heimann, Andreas Ostrowski
#'
#' @details `read.service.blocks()` returns a data.frame array as a list of data.frames.
#' @import XML
#' @import RCurl
#' @import getPass
#' @export

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

#' @inheritParams read.service
#' @export
#' @rdname read.service

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


  
  