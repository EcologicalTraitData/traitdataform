# for roxygen2 documentation please edit file R/data.R!

eltontraits_bird <- utils::read.csv("https://ndownloader.figshare.com/files/5631081", sep = "\t",
                                                           stringsAsFactors = FALSE)

eltontraits_mam <- utils::read.csv("https://ndownloader.figshare.com/files/5631084", sep = "\t",
                               stringsAsFactors = FALSE)


eltontraits_bird[setdiff(names(eltontraits_mam), names(eltontraits_bird))] <- NA
eltontraits_mam[setdiff(names(eltontraits_bird), names(eltontraits_mam))] <- NA

eltontraits <- rbind(eltontraits_bird, eltontraits_mam)

rm(eltontraits_bird, eltontraits_mam)

attr(eltontraits,'metadata') <- traitdataform::as.metadata(
  datasetName = "EltonTraits 1.0",
  datasetID = "eltontraits",
  bibliographicCitation = utils::bibentry(
    bibtype = "Article",
    title = "EltonTraits 1.0: Species‐level foraging attributes of the world's birds and mammals",
    journal = "Ecology",
    volume = 95,
    pages = 2027,
    author = c(utils::as.person(
      "Hamish Wilman", "Jonathan Belmaker", "Jennifer Simpson", "Carolina de la Rosa", "Marcelo M. Rivadeneira"),
      utils::person(given = "Walter", family = "Jetz", email = "walter.jetz@yale.edu")), 
    year = 2014,
    doi = "10.1890/13-1917.1"
  ),
  author = "Walter Jetz",
  license = "http://creativecommons.org/publicdomain/zero/1.0/",
  description = "Species are characterized by physiological, behavioral, and ecological attributes that are all subject to varying evolutionary and ecological constraints and jointly determine their role and function in ecosystems. Attributes such as diet, foraging strata, foraging time, and body size, in particular, determine a large portion of the “Eltonian” niches of species. Here we present a global species-level compilation of these key attributes for all 9993 and 5400 extant bird and mammal species derived from key literature sources. Global handbooks and monographs allowed the consistent sourcing of attributes for most species. For diet and foraging stratum we followed a defined protocol to translate the verbal descriptions into standardized, semiquantitative information about relative importance of different categories. Together with body size (continuous) and activity time (categorical) this enables a much finer distinction of species’ foraging ecology than typical categorical guild assignments allow. Attributes lacking information for specific species were flagged, and interpolated values based on taxonomy were provided instead. The presented data set is limited by, among others, these select cases missing observed data, by errors and uncertainty in the expert assessment as presented in the literature, and by the lack of intraspecific information. However, the standardized and transparent nature and complete global coverage of the data set should support an array of potential studies in biogeography, community ecology, macroevolution, global change biology, and conservation. Potential uses include comparative work involving these traits as focal or secondary variables, ecological research on the trait or trophic structure of communities, or conservation science concerned with the loss of function among species or in ecosystems in a changing world. We hope that this publication will spur the sharing, collaborative curation, and extension of data to the benefit of a more integrative, rigorous, and global biodiversity science."
)