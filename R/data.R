#'
"glossary"

#'
"exploratories"

#' @title Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany
#' 
#' @return When using this data, please cite the original publication: 
#' >   Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany. Scientific Data 2: 150013. http://dx.doi.org/10.1038/sdata.2015.13
#' Additionally, please cite the Dryad data package:
#' >   Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany. Dryad Digital Repository. http://dx.doi.org/10.5061/dryad.53ds2
#' @authors Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW
#' @license Creative Commons 0 (http://creativecommons.org/publicdomain/zero/1.0/). To the extent possible under law, the authors have waived all copyright and related or neighboring rights to this data.
#' @export 
#' @URL DOI: http://dx.doi.org/10.5061/dryad.53ds2
"arthropodtraits"

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



#' @title Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany
#' @export
#' 
#' @citation https://figshare.com/articles/Data_Paper_Data_Paper/3561936
"heteropteraRaw" 
"heteroptera" 

heteropteraRaw <- read.table("https://ndownloader.figshare.com/files/5633883", sep = "\t", header = TRUE)
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


heteroptera <- read.table("https://ndownloader.figshare.com/files/5633880", sep = "\t", header = TRUE)
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

#' @title Carabid morphological traits
#' 
#' @details Column names: name_correct = species name; source_measurement = researcher who performed measurement; body_length = body length in mm; antenna_length = antenna length in mm; metafemur_length = length metafemur in mm; eyewith_corr = eye width in mm; note = note; resid_femur = residual femur length in mm (i.e. residual from linear model in which femur length is explained by body length); resid_eye = residual eye length in mm (i.e. residual from linear model in which eye length is explained by body length) resid_antenna = residual antenna length in mm (i.e. residual from linear model in which antenna length is explained by body length)
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


#' @import readxl
#' @export

"passerines"
temp <- tempfile(fileext = ".zip")
download.file("http://onlinelibrary.wiley.com/store/10.1002/ecy.1783/asset/supinfo/ecy1783-sup-0002-DataS1.zip?v=1&s=361647dd673d04c9b0838931cda1cf28e1f6eb1f", temp, method = "curl", quiet = TRUE)
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
  author = c(person(given = "Robert", middle = "E.", family = "Ricklefs" , email = "ricklefs@umsl.edu")
  ),
  year = 2017,
  doi = "10.1002/ecy.1783"
)
print({cat("loading dataset 'passerines' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(passerines)$citeAs) })



