# for roxygen2 documentation please edit file R/data.R!

heteroptera <- utils::read.csv(url("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraits.txt"), 
                               sep = "\t", header = TRUE, 
                               stringsAsFactors=TRUE,
                               fileEncoding = "latin1"
                               )

attr(heteroptera, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "Morphometric measures of Heteroptera sampled in grasslands across three regions of Germany",
  journal = "Ecology",
  volume = 96,
  issue = 4,
  pages = 1154,
  author = c(utils::as.person("Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W. Weisser")
  ),
  year = 2015,
  doi = "10.1890/14-2159.1"
)

attr(heteroptera, 'units') <- c("mm", "mm3", rep("unitless", 8))
attr(heteroptera, 'taxa') <- "SpeciesID"

print({cat("loading dataset 'heteroptera' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(heteroptera)$citeAs) })
