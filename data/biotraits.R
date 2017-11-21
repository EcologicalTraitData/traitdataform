
temp <- tempfile(fileext = ".zip")
utils::download.file("https://ndownloader.figshare.com/articles/3556611/versions/1", temp, method = "auto", quiet = TRUE, mode="wb")
utils::unzip(temp, files = "TempTrait_001.txt", exdir = ".")
unlink(temp)
rm(temp)

biotraits <- utils::read.table("TempTrait_001.txt", header = T, fileEncoding = "UCS-2LE", sep="\t", fill=T)
file.remove("TempTrait_001.txt")

attr(biotraits, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "The thermal dependence of biological traits",
  journal = "Ecology",
  volume = 94,
  pages = 1205-1206,
  author = utils::as.person("l, A. I., Pawar, S. and Savage, V. M."),
  year = 2013,
  doi = "10.1890/12-2060.1"
)
print({cat("loading dataset 'biotraits' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(biotraits)$citeAs) })