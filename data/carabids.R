# for roxygen2 documentation please edit file R/data.R!

carabids <- utils::read.table("http://datadryad.org/bitstream/handle/10255/dryad.134418/carabid%20traits%20final.txt", sep = "\t", header = TRUE)

attr(carabids, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "Sensitivity of functional diversity metrics to sampling intensity",
  journal = "Methods in Ecology and Evolution",
  author = c(utils::as.person("Fons van der Plas, Roel van Klink, Pete Manning, Han Olff, Markus Fischer")
  ),
  year = 2017,
  doi = "10.1111/2041-210x.12728"
)

print({cat("loading dataset 'carabids' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(carabids)$citeAs) })
