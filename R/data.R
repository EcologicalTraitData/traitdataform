#' @export 
"glossary"

glossary <- read.csv("https://raw.githubusercontent.com/EcologicalTraitData/TraitDataStandard/master/TraitDataStandard.csv")


# ---------------------------------------------------------------

#' Functional Arthropod Traits
#' 
#' Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany.
#' 
#' @details When using this data, please cite the original publication: 
#' \itemize{
#' \item  Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany. Scientific Data 2: 150013. http://dx.doi.org/10.1038/sdata.2015.13
#' }
#' Additionally, please cite the Dryad data package:
#' \itemize{
#' \item Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany. Dryad Digital Repository. http://dx.doi.org/10.5061/dryad.53ds2
#' }
#' @author Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW
#' @export 
#' @family rawdata
#' @source \url{http://dx.doi.org/10.5061/dryad.53ds2}; \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons 0}. To the extent possible under law, the authors have waived all copyright and related or neighboring rights to this data.

arthropodtraits <- read.csv("http://datadryad.org/bitstream/handle/10255/dryad.76638/ArthropodSpeciesTraits.txt?sequence=1", sep = "\t")
attr(arthropodtraits, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany.",
  journal = "Scientific Data",
  volume = 2,
  pages = 150013,
  author = c(as.person("Martin M Gossner , Nadja K Simons, R Achtziger, T Blick, WHO Dorow, F Dziock, F Köhler, W Rabitsch, Wolfgang W Weisser")
  ),
  year = 2015,
  doi = "10.1038/sdata.2015.13"
)
print({cat("loading dataset 'arthropodtraits' from original data source! \n When using this data, please cite the original publication: \n") 
(attributes(arthropodtraits)$citeAs) })

# ---------------------------------------------------------------

#' Heteroptera morphometry traits
#' 
#' Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany.
#' 
#' @author Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W. Weisser
#' @source \url{https://figshare.com/articles/Data_Paper_Data_Paper/3561936}
#' @seealso  \code{\link{arthropodtraits}},  \code{\link{passerines}},
#' @description The data sets comprise morphometric trait data of species that were sampled and measured within the a subproject of the Biodiversity Exploratories Project (Fischer et al. 2010) which focuses on the  effect of land use on arthropod community composition and related processes in three regions of Germany (Gossner et al. 2014, Simons et al. 2014, Simons et al. 2015).
#' @return The dataset \code{heteropteraRaw} contains multiple observations of each species (occurence table). The dataset \code{heteroptera} is a compiled species-trait matrix. 
#' @details Cite this dataset as: 
#' \itemize{ 
#' \item M. Gossner, Martin; K. Simons, Nadja; Höck, Leonhard; W. Weisser, Wolfgang (2016): Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany. figshare. https://doi.org/10.6084/m9.figshare.c.3307611.v1 
#' }
#' @family rawdata
#' @export

heteropteraRaw <- read.table("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraitsRAW.txt", sep = "\t", header = TRUE, colClasses = c(Center_Sampling_region = "NULL"))
attr(heteropteraRaw, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany",
  journal = "Ecology",
  volume = 96,
  issue = 4,
  pages = 1154,
  author = c(as.person("Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W. Weisser")
  ),
  year = 2015,
  doi = "10.1890/14-2159.1"
)
print({cat("loading dataset 'heteropteraRaw' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(heteropteraRaw)$citeAs) })


#' @rdname heteropteraRaw
#' @export
#' @family rawdata

heteroptera <- read.csv("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraits.txt", sep = "\t", header = TRUE, stringsAsFactors=FALSE, fileEncoding="latin1")
attr(heteroptera, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany",
  journal = "Ecology",
  volume = 96,
  issue = 4,
  pages = 1154,
  author = c(as.person("Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W. Weisser")
  ),
  year = 2015,
  doi = "10.1890/14-2159.1"
)
print({cat("loading dataset 'heteroptera' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(heteroptera)$citeAs) })


# ---------------------------------------------------------------


#' @title Carabid morphological traits
#' 
#' @details Column names: name_correct = species name; source_measurement = researcher who performed measurement; body_length = body length in mm; antenna_length = antenna length in mm; metafemur_length = length metafemur in mm; eyewith_corr = eye width in mm; note = note; resid_femur = residual femur length in mm (i.e. residual from linear model in which femur length is explained by body length); resid_eye = residual eye length in mm (i.e. residual from linear model in which eye length is explained by body length) resid_antenna = residual antenna length in mm (i.e. residual from linear model in which antenna length is explained by body length)
#' @family rawdata
#' 
#' @export

carabids <- read.table("http://datadryad.org/bitstream/handle/10255/dryad.134418/carabid%20traits%20final.txt", sep = "\t", header = TRUE)
attr(carabids, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "Sensitivity of functional diversity metrics to sampling intensity",
  journal = "Methods in Ecology and Evolution",
  author = c(as.person("Fons van der Plas, Roel van Klink, Pete Manning, Han Olff, Markus Fischer")
  ),
  year = 2017,
  doi = "10.1111/2041-210x.12728"
)
print({cat("loading dataset 'carabids' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(carabids)$citeAs) })

# ---------------------------------------------------------------



#' @title Passerine morphology: external measurements of approximately one-quarter of passerine bird speciess
#' 
#' @author Robert E. Ricklefs
#' @source Ricklefs, R. E. (2017), Passerine morphology: external measurements of approximately one-quarter of passerine bird species. Ecology, 98: 1472. doi: 10.1002/ecy.1783 \url{http://onlinelibrary.wiley.com/doi/10.1002/ecy.1783/suppinfo}
#' 
#' @family rawdata
#' @import readxl
#' @import curl
#' @export

"passerines"
temp <- tempfile(fileext = ".zip")
download.file("http://onlinelibrary.wiley.com/store/10.1002/ecy.1783/asset/supinfo/ecy1783-sup-0002-DataS1.zip?v=1&s=361647dd673d04c9b0838931cda1cf28e1f6eb1f", temp, method = "auto", quiet = TRUE, mode="wb")
unzip(temp, files = "Measurements of passerine birds.xlsx", exdir = ".")
unlink(temp)
passerines <- readxl::read_xlsx("Measurements of passerine birds.xlsx", sheet = 1)
file.remove("Measurements of passerine birds.xlsx")

attr(passerines, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "Passerine morphology: external measurements of approximately one-quarter of passerine bird species",
  journal = "Ecology",
  volume = 98,
  issue = 5,
  pages = 1472,
  author = c(person(given = "Robert E.", family = "Ricklefs" , email = "ricklefs@umsl.edu")
  ),
  year = 2017,
  doi = "10.1002/ecy.1783"
)
print({cat("loading dataset 'passerines' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(passerines)$citeAs) })

# ---------------------------------------------------------------


#' @export
#"angiosperms"
#temp <- read.csv("http://datadryad.org/bitstream/handle/10255/dryad.59005/GlobalLeafPhenologyDatabase.csv?sequence=1")

#' @export
#"thermal"
#thermal <- read.csv2("https://ndownloader.figshare.com/files/5626476")


# ---------------------------------------------------------------


#' Amniote life-history traits
#' 
#' An amniote life-history database to perform comparative analyses with birds, mammals, and reptiles 
#' @family rawdata
#' @export
"amniota"

amniota <- read.csv("http://esapubs.org/archive/ecol/E096/269/Data_Files/Amniote_Database_Aug_2015.csv")

attr(amniota, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "An amniote life-history database to perform comparative analyses with birds, mammals, and reptiles",
  journal = "Ecology",
  volume = 96,
  issue = 5,
  pages = 3109,
  author = c(person(given = "Nathan", middle = "P.", family = "Myhrvold" , email = "nathanm@intven.com")
  ),
  year = 2015,
  doi = "10.1890/15-0846.1"
)
print({cat("loading dataset 'amniota' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(amniota)$citeAs) })

# ---------------------------------------------------------------

#' Mammal diet database
#' 
#' Establishing macroecological trait datasets: digitalization, extrapolation, and validation of diet preferences in terrestrial mammals worldwide.s
#' 
#' @family rawdata
#' @export
"mammaldiet"

mammaldiet <- read.csv("http://datadryad.org/bitstream/handle/10255/dryad.64565/MammalDIET_v1.0.txt?sequence=1", sep = "\t")

attr(mammaldiet, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "Establishing macroecological trait datasets: digitalization, extrapolation, and validation of diet preferences in terrestrial mammals worldwide",
  journal = "Ecology and Evolution",
  volume = 4,
  issue = 12,
  pages = 2913-2930,
  author = c(person(given = "Wilm Daniel", family = "Kissling", email = "danielkissling@web.de")
  ),
  year = 2014,
  doi = "10.1002/ece3.1136"
)
print({cat("loading dataset 'mammaldiet' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(mammaldiet)$citeAs) })

# ---------------------------------------------------------------

#' PanTHERIA mammal traits
#' 
#' PanTHERIA: a species-level database of life history, ecology, and geography of extant and recently extinct mammals.
#' 
#' @export
#' 
#' @details Data were gathered from the literature for 25 types of ecological and life history information for any extant or recently extinct species within class Mammalia (100740 data lines): 1. Activity Cycle; 2. Age at Eye Opening; 3. Age at First Birth; 4. Average Lifespan; 5. Body Mass; 6. Diet; 7. Dispersal Age; 8. Adult Limb Length; 9. Gestation Length; 10. Group Composition & Size; 11. Growth Data; 12. Habitat Layer; 13. Head-Body Length; 14. Interbirth Interval; 15. Litter size; 16. Litters Per Year; 17. Maximum Longevity; 18. Metabolic Rate; 19. Migratory Behaviour; 20. Mortality Data;  21. Population Density; 22. Ranging Behaviour; 23. Sexual Maturity Age; 24. Teat Number; and 25. Weaning Age. 30 specific variables (see Class IV, Table 1) were extracted from the above data types for PanTHERIA from a total of 94729 data lines (before error checking). Additionally, 4 variables were derived from extracted variables within PanTHERIA and 19 variables were calculated from other spatial data sources (see Class V, Section C). 
#' see http://esapubs.org/archive/ecol/E090/184/metadata.htm for further information.
#' 
#' @source \url {http://esapubs.org/archive/ecol/E090/184/metadata.htm}; \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons 0}. To the extent possible under law, the authors have waived all copyright and related or neighboring rights to this data.
#' @family rawdata
"pantheria"

pantheria <- read.csv("http://esapubs.org/archive/ecol/E090/184/PanTHERIA_1-0_WR05_Aug2008.txt", sep = "\t")

length(unique(paste(pantheria$MSW05_Genus, pantheria$MSW05_Species)))

attr(pantheria, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "PanTHERIA: a species-level database of life history, ecology, and geography of extant and recently extinct mammals",
  journal = "Ecology",
  volume = 90,
  pages = 2648,
  author = c(person(given = "Kate E.", family = "Jones", email = "Kate.Jones@ioz.ac.uk"), as.person("Jon Bielby, Marcel Cardillo, Susanne A. Fritz, Justin O'Dell, C. David L. Orme, Kamran Safi, Wes Sechrest, Elizabeth H. Boakes, Chris Carbone, Christina Connolly, Michael J. Cutts, Janine K. Foster, Richard Grenyer, Michael Habib, Christopher A. Plaster, Samantha A. Price, Elizabeth A. Rigby, Janna Rist, Amber Teacher, Olaf R. P. Bininda-Emonds, John L. Gittleman, Georgina M. Mace, and Andy Purvis")
  ),
  year = 2009,
  doi = "10.1890/08-1494.1"
)
print({cat("loading dataset 'pantheria' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(pantheria)$citeAs) })

# ---------------------------------------------------------------

#' AmphiBIO, a global database for amphibian ecological traits
#' 
#' @source Oliveira, B. F. et al. AmphiBIO, a global database for amphibian ecological traits. Sci. Data. 4:170123 doi: 10.1038/sdata.2017.123 (2017). \url{https://doi.org/10.6084/m9.figshare.4644424}; \href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons BY 4.0}. You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
#' @author Brunno Freire Oliveira, Vinícius Avelar São-Pedro, Georgina Santos-Barrera, Caterina Penone, and Gabriel C. Costa
#' @family rawdata
#' @import readxl
#' @import curl
#' @export

"amphibio"
temp <- tempfile(fileext = ".zip")
download.file("https://ndownloader.figshare.com/files/8828578", temp, method = "auto", quiet = TRUE, mode="wb")
unzip(temp, files = "AmphiBIO_v1.csv", exdir = ".")
unlink(temp)
rm(temp)

amphibio <- read.csv("AmphiBIO_v1.csv")
file.remove("AmphiBIO_v1.csv")

attr(passerines, 'citeAs') <- bibentry(
  bibtype = "Article",
  title = "AmphiBIO, a global database for amphibian ecological traits",
  journal = "Scientific Data",
  volume = 4,
  pages = 170123,
  author = as.person("Brunno Freire Oliveira, Vinícius Avelar São-Pedro, Georgina Santos-Barrera, Caterina Penone, and Gabriel C. Costa"),
  year = 2017,
  doi = "10.1038/sdata.2017.123"
)
print({cat("loading dataset 'amphibio' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(amphibio)$citeAs) })
