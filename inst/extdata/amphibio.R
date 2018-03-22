
temp <- tempfile(fileext = ".zip")
utils::download.file("https://ndownloader.figshare.com/files/8828578", temp, method = "auto", quiet = TRUE, mode="wb")
utils::unzip(temp, files = "AmphiBIO_v1.csv", exdir = ".")
unlink(temp)
rm(temp)

amphibio <- utils::read.csv("AmphiBIO_v1.csv")
file.remove("AmphiBIO_v1.csv")

attr(amphibio, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "AmphiBIO, a global database for amphibian ecological traits",
  journal = "Scientific Data",
  volume = 4,
  pages = 170123,
  author = utils::as.person("Brunno Freire Oliveira, Vinícius Avelar São-Pedro, Georgina Santos-Barrera, Caterina Penone, and Gabriel C. Costa"),
  year = 2017,
  doi = "10.1038/sdata.2017.123"
)
print({cat("loading dataset 'amphibio' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(amphibio)$citeAs) })
