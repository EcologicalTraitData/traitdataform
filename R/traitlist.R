#' Title
#'
#' @param x
#' @param traitmap
#' @param units
#' @param thesaurus
#'
#' @return
#' @export
#'
#' @examples
#'
#' traitlist(traitmap = map1$traitmap, thesaurus = map1$traitlist, appliestoall = map1$appliestoall)

traitlist <- function(x = NULL, # a vector of accepted trait names
                      traitmap = NULL, # a trait map list, i.e. a list containing user provided names
                      units = NULL, # a vector of input units (must be of same lenght as x)
                      thesaurus = NULL, # a lookup table of trait names, must contain at least the columns traitName, type_of_data, may contain measurementUnit, factorLevels and description
                      appliestoall = NULL # a data.frame of entries that will be added to all traits. If multiple columns are provided, it will be recycled.
) {
  traitNames_user <- unlist(sapply(traitmap, function(x) return(x[["traitName_user"]]) ))
  traitNames_mapped <- names(traitmap)
  traitNames_accepted <- names(thesaurus$thesaurus)

  out <- rbindlist(lapply(traitNames_mapped,
                          function(i) data.frame(traitName = i, traitmap[[i]])
  ))

  if(!is.null(appliestoall)) out <- cbind(out, appliestoall)

  out <- merge(out, rbindlist(thesaurus$thesaurus), by = "traitName", all.x = TRUE)

  class(out) <- c("data.table", "traitlist","data.frame")
  return(out)
}
