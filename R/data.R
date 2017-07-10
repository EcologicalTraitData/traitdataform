#'
"glossary"



#' @title Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany
#' 
#' @return When using this data, please cite the original publication: 
#' >   Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany. Scientific Data 2: 150013. http://dx.doi.org/10.1038/sdata.2015.13
#' Additionally, please cite the Dryad data package:
#' >   Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany. Dryad Digital Repository. http://dx.doi.org/10.5061/dryad.53ds2

#' @authors Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW
#' @license Creative Commons 0 (http://creativecommons.org/publicdomain/zero/1.0/). To the extent possible under law, the authors have waived all copyright and related or neighboring rights to this data. 
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
print({cat("loading dataset 'arthropodtraits' from original data source! \n When using this data, please cite the original publication: \n") 
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
print({cat("loading dataset 'arthropodtraits' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(heteroptera)$citeAs) })