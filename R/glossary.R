#' Ecological Trait-data Standard vocabulary (ETS)
#' 
#' @description The terms and concepts as defined by the ETS (https://terminologies.gfbio.org/terms/ets/pages/)
"glossary"

# static fallback list of terms of ETS v0.10
fallback <- data.frame(columnName = c("traitID", "scientificName", "traitName", "traitValue", "traitUnit", "verbatimScientificName", "verbatimTraitName", "verbatimTraitValue", "verbatimTraitUnit", "taxonID", "measurementID", "occurrenceID", "warnings", "taxonRank", "kingdom", "phylum", "class", "order", "family", "genus", "basisOfRecord", "basisOfRecordDescription", "references", "measurementResolution", "measurementMethod", "measurementDeterminedBy", "measurementDeterminedDate", "measurementRemarks", "aggregateMeasure", "individualCount", "dispersion", "measurementValue_min", "measurementValue_max", "measurementAccuracy", "statisticalMethod", "sex", "lifeStage", "age", "morphotype", "eventID", "preparations", "samplingProtocol", "year", "month", "day", "eventDate", "locationID", "habitat", "decimalLongitude", "decimalLatitude", "elevation", "geodeticDatum", "verbatimLocality", "country", "countryCode", "occurrenceRemarks", "datasetID", "datasetName", "datasetDescription", "author", "issued", "version", "bibliographicCitation", "conformsTo", "rightsHolder", "rights", "license", "OriginBE", "BEPlotID", "Exploratory", "BEType", "identifier", "trait", "broaderTerm", "narrowerTerm", "relatedTerm", "valueType", "expectedUnit", "factorLevels", "maxAllowedValue", "minAllowedValue", "traitDescription", "comments", "source", "scientificName", "traitName", "traitID", "traitValue", "traitUnit", "scientificNameStd", "traitNameStd", "traitValueStd", "traitUnitStd", "measurementID", "occurrenceID", "basisOfRecord", "basisOfRecordDescription", "identifier", "comments", "scientificNameStd", "traitNameStd", "traitValueStd", "traitUnitStd"))

glossary <- tryCatch( read.csv("https://raw.githubusercontent.com/EcologicalTraitData/ETS/v0.10/ETS.csv"),
          warning = function(war) {
            message("Direct call to ETS failed. A simplified list of terms has been provided. Please check internet connectivity and re-load package!")
            return(fallback) 
            } )
