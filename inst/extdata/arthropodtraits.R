# for roxygen2 documentation please edit file R/data.R!
arthropodtraits <- utils::read.csv(url("https://datadryad.org/stash/downloads/file_stream/41139", 
                                       encoding = "latin1"), 
                                   sep = "\t",
                                   stringsAsFactors = FALSE
)

levels(arthropodtraits$Author) <- iconv(levels(arthropodtraits$Author), to = "UTF-8")


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

attr(arthropodtraits, 'thesaurus') <-  traitdataform:::as.thesaurus(
  Body_Size = traitdataform:::as.trait("Body_Size",
                  expectedUnit = "mm", valueType = "numeric",
                  traitDescription = "Mean body length [mm]",
                  identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"),
  Dispersal_ability = traitdataform:::as.trait("Dispersal_ability",
                  expectedUnit = "unitless", valueType = "factor",
                  factorLevels = c('0' = "very_low", '0.25' = "low", '0.5' = "medium", '0.75' = "high", '1.0' = "very_high"),
                  traitDescription = "Based on wing dimorphism, flying ability, activity ranges, dispersal strategies, individual movement and colonization dynamics, depending on taxon",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Dispersal_ability"),
  Feeding_guild = traitdataform:::as.trait("Feeding_guild",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Fine classification of feeding guild across larval and adult stages; less frequent assignments in brackets",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Feeding_guild"),
  Feeding_guild_short = traitdataform:::as.trait("Feeding_guild_short",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Coarse classification of feeding guild, indicating main feeding source across larval and adult stages ",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Feeding_guild_short"),
  Feeding_mode = traitdataform:::as.trait("Feeding_mode",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "The way nutrients are ingested",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Feeding_mode"),
  Feeding_specialization = traitdataform:::as.trait("Feeding_specialization",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Host plant specialization in herbivores",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Feeding_specialization"),
  Feeding_tissue = traitdataform:::as.trait("Feeding_tissue",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Fine classification on the plant tissues sucking herbivores are feeding on ",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Feeding_tissue"),
  Feeding_plant_part = traitdataform:::as.trait("Feeding_plant_part",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Fine classification on the plant parts chewing herbivores are feeding on",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Feeding_plant_part"),
  Endophagous_lifestyle = traitdataform:::as.trait("Endophagous_lifestyle",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Details on endophagously living larvae",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2
                  Endophagous_lifestyle"),
  Stratum_use = traitdataform:::as.trait("Stratum_use",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Vertical strata used across larval and adult stages; less frequent assignments in brackets",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Stratum_use"),
  Stratum_use_short = traitdataform:::as.trait("Stratum_use_short",
                  expectedUnit = "unitless", valueType = "factor",
                  traitDescription = "Main vertical stratum used across larval and adult stages ",
                  identifier = "https://www.nature.com/articles/sdata201513/tables/2#Stratum_use_short")
)


attr(arthropodtraits, 'taxa') <- "SpeciesID"
attr(arthropodtraits, 'keep') <-  c(measurementRemarks = "Remark")
