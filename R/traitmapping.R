#' Create input-map of dataset-specific trait names, factor levels and units
#'
#' @param traitName_user
#' @param traitName
#' @param traitID
#' @param traitlist
#'
#' @return
#' @export
#'
#' @examples
#'
#' traittable <- traitmapping(
#' traitName_user <- c("pronl1", "pronl2", "pronw1", "pronw2", "ov1", "ov2", "femurleft1", "femurright1", "femurleft2", "femurright2", "forewingleft1", "forewingright1", "forewingleft2", "forewingright2"),
#' traitName <- c("pronotum_length", "pronotum_length", "pronotum_width", "pronotum_width", "ovipositor_length", "ovipositor_length", "hind_femur_length", "hind_femur_length", "hind_femur_length", "hind_femur_length", "front_wing_length", "front_wing_length", "front_wing_length", "front_wing_length")
#' )

traitmapping <- function(traitName_user,
                         traitName = traitName_user,
                         traitID = NULL,
                         traitlist = BExIS.invertebrates,
                         measurementUnit_user = NULL,
                         factorLevels_user = NULL) {

  # various checks
  if(length(traitName_user) != length(traitName)) stop("Can't compare objects of different length! ")
  if(class(traitlist) != "traitlist") stop("Object provided in 'traitlist' is not valid! Must be of class traitlist.")

  if(!all(traitName %in% traitlist$thesaurus$traitName)) stop("argument 'traitName' contains invalid traits! All trait names must be matching those of the accepted trait list.")

  out <- data.frame(
    traitName_user,
    traitName
  )
  out$traitThesaurus <- traitlist$name
  out <- cbind(out, traitID = traitlist$thesaurus[match(traitName, traitlist$thesaurus$traitName), c("traitID")])
  rownames(out) <- 1:length(out$traitName)
  class(out) <- c("data.frame", "traitmap")

  # should return also type_of_data (i.e. categorical, logical, character, integer, or numerical), measurementUnit, and validfactorlevels and optionally ask for input of measurementUnit_user and factor levels map of form 'list(monophag=1, oligophag=2, polyphag=3)' for later conversion of data!

  return(out)
}
