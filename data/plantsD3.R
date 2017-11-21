plantsD3 <- utils::read.table("https://ars.els-cdn.com/content/image/1-s2.0-S1433831913000218-mmc1.txt", header = T, sep=";")

attr(plantsD3, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "D3: The Dispersal and Diaspore Database – Baseline data and statistics on seed dispersal",
  journal = "Perspectives in Plant Ecology, Evolution and Systematics",
  volume = 15,
  number= 3,
  pages = 180-192,
  author = c(utils::person(given = "Oliver", family = "Tackenberg", email = "tackenberg@bio.uni-frankfurt.de"), utils::as.person("Christina Hintze, Felix Heydel, Christina Hoppe, Sarah Cunze, Andreas König, Oliver Tackenberg")
  ),
  year = 2013,
  doi = "https://doi.org/10.1016/j.ppees.2013.02.001"
)
print({cat("loading dataset 'plantsD3' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(plantsD3)$citeAs) })



