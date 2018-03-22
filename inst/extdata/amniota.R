
amniota <- utils::read.csv("http://esapubs.org/archive/ecol/E096/269/Data_Files/Amniote_Database_Aug_2015.csv",
                           fileEncoding = "UTF-8")

attr(amniota, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "An amniote life-history database to perform comparative analyses with birds, mammals, and reptiles",
  journal = "Ecology",
  volume = 96,
  issue = 5,
  pages = 3109,
  author = c(utils::person(given = "Nathan P.", family = "Myhrvold" , email = "nathanm@intven.com"), utils::as.person(c("Elita Baldridge", "Benjamin Chan", "Dhileep Sivam", "Daniel L. Freeman", "S. K. Morgan Ernest")) 
             ),
  year = 2015,
  doi = "10.1890/15-0846.1"
)
print({cat("loading dataset 'amniota' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(amniota)$citeAs) })