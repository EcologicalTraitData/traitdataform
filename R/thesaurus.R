#' Create a lookup table of trait definitions (a thesaurus of traits)
#'
#' @param x 
#' @param replace 
#' @param appliestoall 
#' @param ... 
#'
#' @return a list of formalized objects of class 'trait', as returned by function as.trait().
#' 
#' @details the object class 'trait' comprises necessary information to map a trait name to a  trait definition, a target unit and a globally unique identifier. The thesaurus will be used in function 'standardize.traits()' to apply unit conversion and factor level harmonization. 
#' 
#' @export
#'
#' @examples
#' 
#' as.thesaurus(body_length = as.trait("body_length", traitUnit = "mm", traitUnitStd = "mm"), 
#'              antenna_length = as.trait("antenna_length", traitUnitStd = "mm"),
#'              metafemur_length = as.trait("metafemur_length"),
#'              eyewidth = as.trait("eyewidth_corr")
#' )
#' 
#' as.thesaurus(data.frame(
#'   traitName = c("body_length", "antenna_length", "metafemur_length", "eyewidth_corr"),
#'   # traitNameStd = traitName,
#'   traitUnit = "mm",
#'   traitType = "numeric",
#'   traitDescription = c("body length in mm", "length of antenna in mm", "length of metafemur in mm", "eye width in mm")
#' )
#' )

as.thesaurus <- function(...) {
  if( "data.frame" %in% class(..1)) {
    out <- lapply(split(..1, f = ..1$traitName, drop= TRUE), function(y) do.call(as.trait, y))
    
  }
  if("trait" %in% class(..1)) {
    out <- list(...)
  }
  if(! "trait" %in% class(..1) && ! "data.frame" %in% class(..1)) stop("no valid input for creating a thesaurus")
  
  class(out) <- c("thesaurus", "list")
  return(out)
}

#' Create a trait definition
#'
#' @param traitName 
#' @param traitID 
#' @param author 
#' @param URI 
#' @param traitUnit 
#' @param factorLevels 
#' @param traitDescription 
#' @param bibliographicReference 
#' @param version 
#' @param ... 
#'
#' @returnh
#' @export
#'
#' @examples
#' 
#' body_size = as.trait("body_size", traitID = "http://url.to/thesaurus.html#body_size", author = "F.D. Schneider", traitDescription = "body length from head  to end of abdomen in mm")
#' 
as.trait <- function(
  traitName,
  traitID = NA,
  author = NA,
  URI = NA,
  traitUnit = NA,
  traitUnitStd = traitUnit,
  factorLevels = NA,
  traitType = NA,
  traitDescription = NA,
  bibliographicReference = NA,
  version = NA,
  ...
) {
  out <- list(traitName = traitName,
              traitID = traitID,
              author = author,
              URI = URI,
              traitUnit = traitUnit,
              traitUnitStd = traitUnitStd,
              factorLevels = factorLevels,
              traitType = traitType,
              traitDescription = traitDescription,
              bibliographicReference = bibliographicReference,
              version = version
              )
  class(out) <- c("trait", "list")
  return(out)
}

#print.trait <- function(x) {
#  cat("traitName:")
#}