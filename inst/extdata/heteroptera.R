# for roxygen2 documentation please edit file R/data.R!
if(!l10n_info()$`UTF-8`) {suppressWarnings(Sys.setlocale("LC_CTYPE", "en_US.UTF-8"))}

heteroptera<-  utils::read.delim(url("https://ndownloader.figshare.com/files/5633880", 
                                          encoding = "latin1"), sep = "\t", header = TRUE,
                                      stringsAsFactors=FALSE)

Encoding(heteroptera$Author) <- "latin1"
heteroptera$Author <- iconv(heteroptera$Author, "latin1", "UTF-8")

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
