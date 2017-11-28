# for roxygen2 documentation please edit file R/data.R!

heteroptera_raw <- utils::read.table("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraitsRAW.txt", 
                                     sep = "\t", header = TRUE,
                                     #colClasses = c(Center_Sampling_region = "NULL"),
                                     fill = TRUE
                                     )

# clarify file encodings for columns with umlauts:
heteroptera_raw$Center_Sampling_region <- iconv(heteroptera_raw$Center_Sampling_region, to = "UTF-8")
heteroptera_raw$Voucher_ID <- iconv(heteroptera_raw$Voucher_ID, to = "UTF-8")
heteroptera_raw$Source <- iconv(heteroptera_raw$Source, to = "UTF-8")

attr(heteroptera_raw, 'metadata') <- traitdataform::as.metadata(
  datasetName = "Heteroptera morphometry traits",
  datasetID = "heteroptera",
  bibliographicCitation =  utils::bibentry(
    bibtype = "Article",
    title = "Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany",
    journal = "Ecology",
    volume = 96,
    issue = 4,
    pages = 1154,
    author = c(utils::as.person("Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W. Weisser")),
    year = 2015,
    doi = "10.1890/14-2159.1"
  ),
  author = "Martin M. Gossner",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)

attr(heteroptera_raw, 'thesaurus') <-  traitdataform::as.thesaurus(
  Wing_development = traitdataform::as.trait("Wing_development", expectedUnit = "unitless", valueType = "factor",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Wing_development"),
  Body_length = traitdataform::as.trait("Body_length", expectedUnit = "mm", valueType = "numeric",
                                             identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"),
  Body_width = traitdataform::as.trait("Body_width", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_width"),
  Body_height = traitdataform::as.trait("Body_height", expectedUnit = "mm", valueType = "numeric",
                                       identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_width"),
  Thorax_length = traitdataform::as.trait("Thorax_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"),
  Thorax_width = traitdataform::as.trait("Thorax_width", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_width"),
  Head_width = traitdataform::as.trait("Head_width", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_width"),
  Eye_width = traitdataform::as.trait("Eye_width", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Eye_diameter"),
  Antenna_Seg1 = traitdataform::as.trait("Antenna_Seg1", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg2 = traitdataform::as.trait("Antenna_Seg2", expectedUnit = "mm", valueType = "numeric",
                                         identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg3 = traitdataform::as.trait("Antenna_Seg3", expectedUnit = "mm", valueType = "numeric",
                                         identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg4 = traitdataform::as.trait("Antenna_Seg4", expectedUnit = "mm", valueType = "numeric",
                                         identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg5 = traitdataform::as.trait("Antenna_Seg5", expectedUnit = "mm", valueType = "numeric",
                                         identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Front.Tibia_length = traitdataform::as.trait("Front.Tibia_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = " 	http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_width"),
  Mid.Tibia_length = traitdataform::as.trait("Mid.Tibia_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Tibia_length"),
  Hind.Tibia_length = traitdataform::as.trait("Hind.Tibia_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Tibia_length"),
  Front.Femur_length = traitdataform::as.trait("Front.Femur_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length"),
  Hind.Femur_length = traitdataform::as.trait("Hind.Femur_length", expectedUnit = "mm", valueType = "numeric",
                                              identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length"),
  Front.Femur_width = traitdataform::as.trait("Front.Femur_width", expectedUnit = "mm", valueType = "numeric",
                                              identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Femur_width"),
  Hind.Femur_width = traitdataform::as.trait("Hind.Femur_width", expectedUnit = "mm", valueType = "numeric",
                                             identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Femur_width"),
  Rostrum_length = traitdataform::as.trait("Rostrum_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Nutrition_morphology"),
  Rostrum_width = traitdataform::as.trait("Rostrum_width", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Nutrition_morphology"),
  Wing_length = traitdataform::as.trait("Wing_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Wing"),
  Wing_width = traitdataform::as.trait("Wing_width", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Wing")
)


attr(heteroptera, 'taxa') <- "SpeciesID"
attr(heteroptera, 'keep') <-  c(basisOfRecord = "PreservedSpecimen", references="Author", sex="Sex", 
                                references = "Source", measurementRemarks = "Voucher_ID",
                                measurementID = "ID")
