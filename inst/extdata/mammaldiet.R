# for roxygen2 documentation please edit file R/data.R!

mammaldiet <- utils::read.csv(suppdata("10.5061/dryad.6cd0v", "MammalDIET_v1.0.txt"),
                              sep = "\t",
                              fileEncoding = "UTF-8",
                              stringsAsFactors = FALSE
                              )

attr(mammaldiet, 'metadata') <- traitdataform::as.metadata(
  datasetName = "MammalDIET",
  datasetID = "mammaldiet",
  bibliographicCitation =  utils::bibentry(
    bibtype = "Article",
    title = "Establishing macroecological trait datasets: digitalization, extrapolation, and validation of diet preferences in terrestrial mammals worldwide",
    journal = "Ecology and Evolution",
    volume = 4,
    issue = 12,
    pages = 2913-2930,
    author = c(utils::person(given = "Wilm Daniel", family = "Kissling", email = "danielkissling@web.de"), utils::person(given = "Lars", family = "Dalby"), utils::person(given = "Camilla", family = "Fløjgaard"), utils::person(given = "Jonathan", family = "Lenoir"), utils::person(given = "Brody", family = "Sandel"), utils::person(given = "Christopher", family = "Sandom"), utils::person(given = "Kristian", family = "Trøjelsgaard"), utils::person(given = "Jens-Christian", family = "Svenning")),
    year = 2014,
    doi = "10.1002/ece3.1136"
    ),
  author = "Wilm Daniel Kissling",
  license = "http://creativecommons.org/publicdomain/zero/1.0/",
  description = "Ecological trait data are essential for understanding the broad-scale distribution of biodiversity and its response to global change. For animals, diet represents a fundamental aspect of species’ evolutionary adaptations, ecological and functional roles, and trophic interactions. However, the importance of diet for macroevolutionary and macroecological dynamics remains little explored, partly because of the lack of comprehensive trait datasets. We compiled and evaluated a comprehensive global dataset of diet preferences of mammals (“MammalDIET”). Diet information was digitized from two global and cladewide data sources and errors of data entry by multiple data recorders were assessed. We then developed a hierarchical extrapolation procedure to fill-in diet information for species with missing information. Missing data were extrapolated with information from other taxonomic levels (genus, other species within the same genus, or family) and this extrapolation was subsequently validated both internally (with a jack-knife approach applied to the compiled species-level diet data) and externally (using independent species-level diet information from a comprehensive continentwide data source). Finally, we grouped mammal species into trophic levels and dietary guilds, and their species richness as well as their proportion of total richness were mapped at a global scale for those diet categories with good validation results. The success rate of correctly digitizing data was 94%, indicating that the consistency in data entry among multiple recorders was high. Data sources provided species-level diet information for a total of 2033 species (38% of all 5364 terrestrial mammal species, based on the IUCN taxonomy). For the remaining 3331 species, diet information was mostly extrapolated from genus-level diet information (48% of all terrestrial mammal species), and only rarely from other species within the same genus (6%) or from family level (8%). Internal and external validation showed that: (1) extrapolations were most reliable for primary food items; (2) several diet categories (“Animal,” “Mammal,” “Invertebrate,” “Plant,” “Seed,” “Fruit,” and “Leaf”) had high proportions of correctly predicted diet ranks; and (3) the potential of correctly extrapolating specific diet categories varied both within and among clades. Global maps of species richness and proportion showed congruence among trophic levels, but also substantial discrepancies between dietary guilds. MammalDIET provides a comprehensive, unique and freely available dataset on diet preferences for all terrestrial mammals worldwide. It enables broad-scale analyses for specific trophic levels and dietary guilds, and a first assessment of trait conservatism in mammalian diet preferences at a global scale. The digitalization, extrapolation and validation procedures could be transferable to other trait data and taxa.",
  taxonomy = "IUCN 2013"
  )
  
mammaldiet$scientificName <- paste(mammaldiet$Genus, mammaldiet$Species)

attr(mammaldiet, 'taxa') <- "scientificName"
attr(mammaldiet, 'traits') <- names(mammaldiet[c(6:21,24:29)])
attr(mammaldiet, 'keep') <-  c(basisOfRecord = "DataSource")
