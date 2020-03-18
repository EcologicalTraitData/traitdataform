#' Standardize scientific names of species
#'
#' @description Adds columns to a traitdata object containing accepted species
#'   names and relates to globally unique taxon identifiers via URI.
#'
#' @param x a traitdata object (as returned by `as.traitdata()`) or a data table
#'   containing at least the column `scientificName.
#' @param method default option is `get_gbif_taxonomy`. In principle, takes any
#'   function that takes a vector of species names as input to produce a
#'   taxonomy lookup table (i.e. mapping user-provided `scientificName` to
#'   `taxonID` and other taxon-level information). Will allow to chose from
#'   different sources of taxonomic reference.
#' @param method_options a name vector of arguments to be passed on to `method`.
#'   See [get_gbif_taxonomy] for options.
#' @param return a character vector containing the informatoin that should be
#'   extracted into the output. Valid entries are the column names returned by
#'   function `get_gbif_taxonomy()`. See 'Details'.
#' @param ... parameters to be ignored, forwarded from wrapper function
#'   `standardize()`.
#'
#' @details Taxonomic standardisation is an enormous challenge for biodiversity
#'   data management and research. Constant changes in species and higher taxa,
#'   refinements of phylogenetic trees and changing attribution to original
#'   authors, moving species into other genera or difficulties to place species
#'   into the Linean nomenclature results in highly fluctuent taxonomic
#'   definitions.
#'
#'   As a consequence, there is not one reference for accepted species names and
#'   depending on the field of resaerch and taxonomic focus other authorities
#'   will be employed.
#'
#'   For reasons of simplicity and because of its high coverage of taxa, the
#'   function `standardize.taxonomy()` uses the GBIF Backbone Taxonomy as its
#'   reference system and resolves all provided species names to the accepted
#'   name according to GBIF (resolving misspellings and synonyms in the
#'   process). We invite pull requests to make this function more general and
#'   enable a choice of a taxonomic reference.
#'
#' @export
#' @family standardize
#' @aliases standardize.taxonomy standardise_taxa
#'
#'
#' @examples
#' 
#' \dontrun{
#' 
#' pulldata("carabids")
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
#' dataset1Std <- standardize_taxa(dataset1)
#' }
standardize_taxa <- function(x, 
                                 method = get_gbif_taxonomy, 
                                 method_options = c(subspecies = TRUE, 
                                    higherrank = FALSE, 
                                    verbose = FALSE, 
                                    fuzzy  = TRUE, 
                                    conf_threshold = 90,
                                    resolve_synonyms = TRUE),
                                 return = c("kingdom",
                                            "phylum",
                                            "class",
                                            "order",
                                            "family"
                                            ), 
                                 ...) {

  #if(!"traitdata" %in% class(x)) x <- as.traitdata(x, ...)
    
  # call method to handle name mapping
  temp <- do.call(method, c(list(levels(droplevels(as.factor(x$scientificName)))), method_options))
  
  # merge simplified output into input table
  out <- merge.data.frame(x, temp[, unique(c( "taxonID", "scientificNameStd", "scientificName",
                                              "taxonRank", "warnings", return))], 
                          by.x = "scientificName", by.y = "scientificName")
  
  #TODO: produce warning for unmatched names!
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  # keep attributes of x
  attribs <- attributes(x)
  attribs$names <- attributes(out)$names
  attribs$row.names <- seq_along(out[,1])
  attributes(out) <- attribs
  
  # write taxonomy table to attributes
  attr(out, "taxonomy") <- temp
  
  return(out)
}

#' @export
#' 
standardise_taxa <- standardize_taxa

#' @export
#' 
standardize.taxonomy <- standardize_taxa



#' Standardize trait names and harmonize measured values and reported facts
#' 
#' @description Adds columns to a traitdata table with standardized trait names 
#'   and relates them to globally unique identifiers via URIs. Optionally 
#'   converts units of values and renames factor levels into accepted terms.
#'   
#' @param x a traitdata object (as returned by `as.traitdata()`) or a data table
#'   containing at least the column `scientificName.
#' @param thesaurus an object of class 'thesaurus' (as returned by
#'   `as.thesaurus()`).
#' @param rename a named vector to map user-provided names to thesaurus object
#'   names (see Details).
#' @param categories target categories for binary/logical traits harmonization.
#' @param output behaviour of `fixlogical()`. see [fixlogical()].
#' @param ... parameters to be ignored, forwarded from wrapper function `standardize()`.
#'   
#' @import units
#' @export
#' @family standardize
#' 
#' @details The function matches the trait names provided in 'traitName' to the
#'   traits provided in the thesaurus (in field 'trait'). Matching must be exact
#'   (case sensitive). Fuzzy matching may be provided in a later version of the
#'   package.
#'   
#'   The function parameter 'rename' should be provided to map trait names where
#'   user-provided names and thesaurus names are different. In this case, rename
#'   should be a named vector with the target names used in the thesaurus as
#'   names, and the original names as provided in 'traitName' as value. E.g.
#'   `rename = c()`
#'   
#' @aliases standardise_traits standardize.traits
#' @family standardize
#' @examples 
#' 
#' 
#' pulldata("carabids")
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
#' traitlist <- as.thesaurus(
#' body_length = as.trait("body_length", expectedUnit = "mm", valueType = "numeric",
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"), 
#' antenna_length = as.trait("antenna_length", expectedUnit = "mm", valueType = "numeric",
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Antenna_length"),
#' metafemur_length = as.trait("metafemur_length", expectedUnit = "mm", valueType = "numeric",
#'    identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
#' )
#' 
#' dataset1Std <- standardize_traits(dataset1, thesaurus = traitlist)
#' 
#' 
#' 
#' ## Example: matching of original names to thesaurus
#' 
#' pulldata("heteroptera_raw")
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
#' 
#' traits2 <- as.thesaurus(
#'     Body_length = as.trait("Body_length",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "From the tip of the head to the end of the abdomen"),
#'     Antenna_Seg1 = as.trait("Antenna_Seg1",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "Length of first antenna segment",
#'             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
#'     Antenna_Seg2 = as.trait("Antenna_Seg2",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "Length of second antenna segment",
#'             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
#'     Antenna_Seg3 = as.trait("Antenna_Seg3",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "Length of third antenna segment",
#'             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
#'     Antenna_Seg4 = as.trait("Antenna_Seg4",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "Length of fourth antenna segment",
#'             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
#'     Antenna_Seg5 = as.trait("Antenna_Seg5",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "Length of fifth antenna segment (only Pentatomoidea)",
#'             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
#'     Hind.Femur_length = as.trait("Hind.Femur_length",
#'             expectedUnit = "mm", valueType = "numeric",
#'             traitDescription = "Length of the femur of the hind leg",
#'             broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
#'     )
#'
#' dataset2Std <- standardize_traits(dataset2, 
#'     thesaurus = traits2
#'     )
#' 
standardize_traits <- function(x,
                               thesaurus = attributes(x)$thesaurus,
                               rename = NULL,
                               categories = c("No", "Yes"), 
                               output = "logical",
                               ...
                               ) {
  
  traitNameStd = NULL # reserving variable for subsetting (to avoid nots in R CHECK)
  
  x$traitNameStd <- x$traitName
  
  if(!"thesaurus" %in% class(thesaurus)) as.thesaurus(thesaurus)
  
  # build lookup data.frame from thesaurus object
  
  factorLevels <- lapply(thesaurus, function(x) x$factorLevel)
  
  for(i in 1:length(thesaurus)) {
    if(thesaurus[[i]]$valueType == "factor" & length(thesaurus[[i]]$factorLevels) > 1) {
      thesaurus[[i]]$factorLevels <- paste(paste(names(thesaurus[[i]][]$factorLevels), "=", thesaurus[[i]][]$factorLevels), collapse = "; ")
    }
  }
  
  lookup <- do.call(rbind, lapply(thesaurus, data.frame))
  
 
  # if no identifier is provided, set integer values
  if(is.null(levels(lookup$identifier))) lookup$identifier <- as.factor(seq_along(lookup$trait))
  
  
  # map user-provided trait names to thesaurus (i.e. set traitNameStd)
  
  ## if rename provides user name
  if(!is.null(names(rename))) {
    levels(x$traitNameStd) <- rename[match(levels(x$traitName), names(rename) )]
  }
  
  ## if thesaurus provides user name
  if(is.null(rename) && length(thesaurus) == length(levels(x$traitName)) && !is.null(names(thesaurus))) { 
    levels(x$traitNameStd) <- lookup$trait[match(levels(x$traitName), names(thesaurus) )] 
  }
  
  # merge lookup table into original data frame based on user provided trait name mapping
  out <- merge.data.frame(x, lookup[,c("trait","identifier", "expectedUnit" )], by.x = "traitNameStd", by.y = "trait", sort = FALSE )
 
  ## rename columns according to ETS
  colnames(out)[colnames(out) == "trait"] <- "traitNameStd"
  colnames(out)[colnames(out) == "expectedUnit"] <- "traitUnitStd"
  colnames(out)[colnames(out) == "identifier"] <- "traitID"
 
  # generate standardized trait vector
 
  out$traitValueStd <- NA
 
  traits <- levels(droplevels(out$traitNameStd)) 
  
  for(i in traits) { # iterate over all trait categories (by user provided names)
   
   #if(length(lookup[lookup$trait == i,]$valueType) == 1 ) {warning("trait value has not been harmonized to standard terms! To perform standardization provide field 'valueType', as well as 'traitUnitStd' and 'factorLevels' for numeric and factorial traits, respectively!")} else {
    
    
    # TODO: add check of value type if none is provided
    # if(is.na(lookup[lookup$trait == i,]$valueType)) {
    # 
    #   guessed_type <- typeof(templist[[i]]$traitValue)
    #   
    #   warning("no value type has been provided. I take trait", i, "to be ", guessed_type)
    # }
    
  
    # harmonize logical values
    if(lookup[lookup$trait == i,]$valueType == "logical") {
       templist <- split(out, f = out$traitNameStd) 
       out[out$traitNameStd == i,"traitValueStd"] <- fixlogical(templist[[i]]$traitValue, output = output, categories = categories)
     }
     
     ## factor level harmonization
     if(lookup[lookup$trait == i,]$valueType %in% c("factor", "categorical")) { 
       
       value_original <- as_factor_clocale(subset(out, traitNameStd == i)$traitValue)
       #TODO: check if factor level clustering occurs, and harmonize, if switch is set for it
       #value_standardized <- refinr::key_collision_merge(as.character(value_original))
       
       #TODO: remap factor levels according to user provided mapping (e.g. c("f", "female", "xy") all resolve to "f") 
       #out[out$traitNameStd == i, "traitValueStd"] <- value_standardized
       
     } ## end of factor level harmonization
     
     ## unit conversion:
     if(lookup[lookup$trait == i,]$valueType == "numeric") {

       unit_original <- as_factor_clocale(subset(out, traitNameStd == i)$traitUnit)
       unit_target <- as_factor_clocale(subset(out, traitNameStd == i)$traitUnitStd)
       
       # case 1: homogeneous units for the entire trait
       if(length(levels(unit_original)) == 1 && length(levels(unit_target)) == 1) {
         
         unit_original <- as.character(levels(unit_original))
         unit_target <- as.character(levels(unit_target))
         
         ## OLDMETHOD: did not handle squares and operations
         # extract original value
         value_original <- as.numeric(subset(out, traitNameStd == i)$traitValue) * units::as_units(unit_original)
         
         # create vector with standardized value and write into output
         value_standardized <- value_original
         units(value_standardized) <- units::as_units(unit_target)
         out[out$traitNameStd == i, "traitValueStd"] <- value_standardized
         
         
       } else {     # case 2: heterogeneous units used within a single trait
         
         # extract original value
         value_original <-  subset(out, traitNameStd == traits[i])$traitValue
         
         # convert value in standardized value and write into output
         for(j in seq_along(value_original))  {
           
           value_original_j <- value_original[j] * units::parse_unit(unit_original[j]) 
           
           value_standardized_j <- value_original_j
           units(value_standardized_j) <- units::parse_unit(unit_target[j])
           out[out$traitNameStd == i,"traitValueStd"][j] <- value_standardized_j
         }
         
       }
       
     } ## end of unit conversion
     
   }
   
 #}
  
 # sort columns according to glossary of terms
 out <- out[, order(match(names(out), glossary$columnName) )]
 
 # keep attributes of x
 attribs <- attributes(x)
 attribs$names <- attributes(out)$names
 attribs$row.names <- seq_along(out[,1])
 attributes(out) <- attribs
 
 attr(out, "traits") <- lookup
 
 return(out)
}

#' @export
#' 
standardise_traits <- standardize_traits

#' @export
#' 
standardize.traits <- standardize_traits


#' Standardize trait datasets
#' 
#' @description wrapper that applies `standardize.taxonomy()` and
#'   `standardize.traits()` in one go.
#'   
#' @param ... parameters as described for `standardize.traits()` and `standardize.taxonomy()`.
#' 
#' @inheritParams standardize_traits 
#' @inheritParams standardize_taxa
#' 
#' @export
#' 
#' @family standardize
#' 
standardize <- function(x,
                        ...) {
    
                          if("data.frame" %in% class(x) && ! "traitdata" %in% class(x) ) x <- as.traitdata(x,...)
                          x <- standardize.taxonomy(x, ...)
                          x <- standardize.traits(x, ...)
                          return(x)
                      }
