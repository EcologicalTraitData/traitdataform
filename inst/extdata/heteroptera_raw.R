# for roxygen2 documentation please edit file R/data.R!
if(!l10n_info()$`UTF-8`) {suppressWarnings(Sys.setlocale("LC_CTYPE", "en_US.UTF-8"))}

heteroptera_raw <-  utils::read.delim(url("https://ndownloader.figshare.com/files/5633883", 
                                          encoding = "windows-1252"),
                                    stringsAsFactors=TRUE)

heteroptera_raw$Center_Sampling_region <- iconv(as.character(heteroptera_raw$Center_Sampling_region), to = "UTF-8")
levels(heteroptera_raw$Author) <- iconv(levels(heteroptera_raw$Author), to = "UTF-8")
levels(heteroptera_raw$Voucher_ID) <- iconv(levels(heteroptera_raw$Voucher_ID), to = "UTF-8")
levels(heteroptera_raw$Source) <- iconv(levels(heteroptera_raw$Source), to = "UTF-8")



# heteroptera_raw <- data.frame()
# heteroptera_raw <- readr::read_delim("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraitsRAW.txt", 
#                  delim = "\t",  locale = readr:::locale(encoding = "windows-1252"))
# heteroptera_raw <- as.data.frame(heteroptera_raw)


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
    author = c(utils::as.person("Martin M. Gossner , Nadja K. Simons, Leonhard Hoeck, Wolfgang W. Weisser")),
    year = 2015,
    doi = "10.1890/14-2159.1"
  ),
  author = "Martin M. Gossner",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)


attr(heteroptera_raw, 'thesaurus') <-  traitdataform:::as.thesaurus(
  Body_length = traitdataform::as.trait("Body_length",
                                         expectedUnit = "mm", valueType = "numeric",
                                         traitDescription = "From the tip of the head to the end of the abdomen"),
  Body_width = traitdataform::as.trait("Body_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Widest part of the body"),
  Body_height = traitdataform::as.trait("Body_height",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Thickest part of the body"),
  Thorax_length = traitdataform::as.trait("Thorax_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Longest part of the pronotum"),
  Thorax_width = traitdataform::as.trait("Thorax_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Widest part of the pronotum"),
  Head_width = traitdataform::as.trait("Head_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Widest part of the head including eyes"),
  Eye_width = traitdataform::as.trait("Eye_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Widest part of the left eye"),
  Antenna_Seg1 = traitdataform::as.trait("Antenna_Seg1",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of first antenna segment",
                                        broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg2 = traitdataform::as.trait("Antenna_Seg2",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of second antenna segment",
                                        broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg3 = traitdataform::as.trait("Antenna_Seg3",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of third antenna segment",
                                        broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg4 = traitdataform::as.trait("Antenna_Seg4",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of fourth antenna segment",
                                        broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Antenna_Seg5 = traitdataform::as.trait("Antenna_Seg5",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of fifth antenna segment (only Pentatomoidea)",
                                        broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
  Front.Tibia_length = traitdataform::as.trait("Front.Tibia_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of the tibia of the foreleg"
                                               ),
  Mid.Tibia_length = traitdataform::as.trait("Mid.Tibia_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of the tibia of the mid leg",
                                        broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Tibia_length"),
  Hind.Tibia_length = traitdataform::as.trait("Hind.Tibia_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of the tibia of the hind leg",
                                        broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Tibia_length"),
  Front.Femur_length = traitdataform::as.trait("Front.Femur_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of the femur of the foreleg",
                                        broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length"),
  Hind.Femur_length = traitdataform::as.trait("Hind.Femur_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of the femur of the hind leg",
                                        broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length"),
  Front.Femur_width = traitdataform::as.trait("Front.Femur_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Width of the femur of the foreleg"
                                        ),
  Hind.Femur_width = traitdataform::as.trait("Hind.Femur_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Width of the femur of the hind leg"),
  Rostrum_length = traitdataform::as.trait("Rostrum_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Length of the rostrum including all segments"
                                        ),
  Rostrum_width = traitdataform::as.trait("Rostrum_width",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Widest part of the rostrum"
                                        ),
  Wing_length = traitdataform::as.trait("Wing_length",
                                        expectedUnit = "mm", valueType = "numeric",
                                        traitDescription = "Longest part of the forewing",
                                        broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Wing"),
  Wing_width = traitdataform::as.trait("Wing_width",
                                       expectedUnit = "mm", valueType = "numeric",
                                       traitDescription = "Widest part of the forewing",
                                       broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Wing")
)

attr(heteroptera_raw, 'taxa') <- "SpeciesID"
attr(heteroptera_raw, 'units') <- "mm"
attr(heteroptera_raw, 'occurrences') <- "ID"
attr(heteroptera_raw, 'keep') <-  c(sex = "Sex", basisOfRecordDescription = "Source", references = "Voucher_ID", verbatimLocality = "Center_Sampling_region")
