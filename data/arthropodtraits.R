# for roxygen2 documentation please edit file R/data.R!

arthropodtraits <- utils::read.csv("http://datadryad.org/bitstream/handle/10255/dryad.76638/ArthropodSpeciesTraits.txt?sequence=1", 
                                   sep = "\t",
                                   fileEncoding = "latin1"
                                   )

attr(arthropodtraits, 'metadata') <- traitdataform::as.metadata(
  datasetName = "Functional Arthropod Traits",
  datasetID = "arthropodtraits",
  bibliographicCitation =  utils::bibentry(
    bibtype = "Article",
    title = "A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany.",
    journal = "Scientific Data",
    volume = 2,
    pages = 150013,
    author = c(utils::as.person("Martin M Gossner , Nadja K Simons, R Achtziger, T Blick, WHO Dorow, F Dziock, F Köhler, W Rabitsch, Wolfgang W Weisser")
    ),
    year = 2015,
    doi = "10.1038/sdata.2015.13"
  ),
  author = "Martin M Gossner",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)

attr(arthropodtraits, 'thesaurus') <-  traitdataform::as.thesaurus(
  Body_Size = traitdataform::as.trait("Body_Size",
                                         expectedUnit = "mm", valueType = "numeric",
                                         identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"),
  Dispersal_ability = traitdataform::as.trait("Dispersal_ability",
                                         expectedUnit = "unitless", valueType = "integer",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Feeding_guild = traitdataform::as.trait("Feeding_guild",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Feeding_guild_short = traitdataform::as.trait("Feeding_guild_short",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Feeding_mode = traitdataform::as.trait("Feeding_mode",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Feeding_specialization = traitdataform::as.trait("Feeding_specialization",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Feeding_tissue = traitdataform::as.trait("Feeding_tissue",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Feeding_plant_part = traitdataform::as.trait("Feeding_plant_part",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Endophagous_lifestyle = traitdataform::as.trait("Endophagous_lifestyle",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Stratum_use = traitdataform::as.trait("Stratum_use",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513"),
  Stratum_use_short = traitdataform::as.trait("Stratum_use_short",
                                         expectedUnit = "unitless", valueType = "factor",
                                         identifier = "https://www.nature.com/articles/sdata201513")
)


attr(arthropodtraits, 'taxa') <- "SpeciesID"
attr(arthropodtraits, 'keep') <-  c(basisOfRecord = "literatureData", measurementRemarks = "Remark")
