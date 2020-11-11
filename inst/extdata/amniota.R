
temp <- tempfile(fileext = ".zip")
utils::download.file("https://ndownloader.figshare.com/files/8067269", temp, method = "auto", quiet = TRUE, mode="wb")
utils::unzip(temp, files = "Data_Files/Amniote_Database_Aug_2015.csv", exdir = ".")
unlink(temp)
rm(temp)

amniota <- utils::read.csv("Data_Files/Amniote_Database_Aug_2015.csv",
                            fileEncoding = "UTF-8",
                            stringsAsFactors = FALSE)
file.remove("Data_Files/Amniote_Database_Aug_2015.csv")
unlink("Data_Files", recursive=TRUE)

#amniota <- utils::read.csv("http://esapubs.org/archive/ecol/E096/269/Data_Files/Amniote_Database_Aug_2015.csv",
#                           fileEncoding = "UTF-8",
#                           stringsAsFactors = FALSE)

attr(amniota, 'metadata') <- traitdataform::as.metadata(
  datasetName = "Amniote Database",
  datasetID = "amniota",
  bibliographicCitation = utils::bibentry(
    bibtype = "Article",
    title = "An amniote life-history database to perform comparative analyses with birds, mammals, and reptiles",
    journal = "Ecology",
    volume = 96,
    issue = 5,
    pages = 3109,
    author = c(utils::person(given = "Nathan P.", family = "Myhrvold" , email = "nathanm@intven.com"), utils::as.person(c("Elita Baldridge", "Benjamin Chan", "Dhileep Sivam", "Daniel L. Freeman", "S. K. Morgan Ernest")) 
             ),
    year = 2015,
    doi = "10.1890/15-0846R.1"
  ),
  author = "Nathan P. Myhrvold",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)
