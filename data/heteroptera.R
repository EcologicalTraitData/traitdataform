# for roxygen2 documentation please edit file R/data.R!

heteroptera <- utils::read.csv("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraits.txt", 
                               sep = "\t", header = TRUE, 
                               stringsAsFactors=FALSE,
                               fileEncoding = "latin1"
                               )

attr(heteroptera, 'metadata') <- traitdataform::as.metadata(
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


attr(heteroptera, 'thesaurus') <-  traitdataform::as.thesaurus(
  Body_length = traitdataform::as.trait("Body_length", expectedUnit = "mm", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"),
  Body_volume = traitdataform::as.trait("Body_volume", expectedUnit = "mm3", valueType = "numeric",
                                        identifier = " 	http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_dimension"),
  Rel_wing_length = traitdataform::as.trait("Rel_wing_length", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = " 	http://ecologicaltraitdata.github.io/TraitDataList/Wing_size_relation"),
  Hind.Femur_shape = traitdataform::as.trait("Hind.Femur_shape", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = NA),
  Rel_Hind.Femur_length = traitdataform::as.trait("Rel_Hind.Femur_length", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length"),
  Rel_Rostrum_length = traitdataform::as.trait("Rel_Rostrum_length", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = NA),
  Front.Femur_shape = traitdataform::as.trait("Front.Femur_shape", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = NA),
  Rel_eye_size = traitdataform::as.trait("Rel_eye_size", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = NA),
  Rel_Antenna_length = traitdataform::as.trait("Rel_Antenna_length", expectedUnit = "unitless", valueType = "numeric",
                                        identifier = NA)
)


attr(heteroptera, 'taxa') <- "SpeciesID"
attr(heteroptera, 'keep') <-  c(basisOfRecord = "PreservedSpecimen")

print(attributes(heteroptera)$metadata)
