# for roxygen2 documentation please edit file R/data.R!

heteroptera_raw <- utils::read.table("http://www.esapubs.org/archive/ecol/E096/102/HeteropteraMorphometricTraitsRAW.txt", 
                                     sep = "\t", header = TRUE,
                                     #colClasses = c(Center_Sampling_region = "NULL"),
                                     fill = TRUE
                                     )

# clarify file encodings for columns with umlauts:
heteroptera_raw$Center_Sampling_region <- iconv(heteroptera_raw$Center_Sampling_region, to = "UTF-8")
heteroptera_raw$Voucher_ID <- iconv(heteroptera_raw$Voucher_ID, to = "UTF-8")
heteroptera_raw$Source <- iconv(heteroptera_raw$Source, to = "UTF-8")

attr(heteroptera_raw, 'citeAs') <- utils::bibentry(
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
print({cat("loading dataset 'heteroptera_raw' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(heteroptera_raw)$citeAs) })

