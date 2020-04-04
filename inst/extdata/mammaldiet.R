# for roxygen2 documentation please edit file R/data.R!

mammaldiet <- utils::read.csv("https://datadryad.org/stash/downloads/file_stream/21802",
                              sep = "\t",
                              fileEncoding = "UTF-8",
                              stringsAsFactors = FALSE
                              )

attr(mammaldiet, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "Establishing macroecological trait datasets: digitalization, extrapolation, and validation of diet preferences in terrestrial mammals worldwide",
  journal = "Ecology and Evolution",
  volume = 4,
  issue = 12,
  pages = 2913-2930,
  author = c(utils::person(given = "Wilm Daniel", family = "Kissling", email = "danielkissling@web.de")
  ),
  year = 2014,
  doi = "10.1002/ece3.1136"
)
print({cat("loading dataset 'mammaldiet' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(mammaldiet)$citeAs) })
