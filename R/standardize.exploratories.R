#' Standardize Georeference from Biodiversity Exploratories Plot ID
#'
#' @description Adds columns of georeference to trait-data table if measurements
#'   relate to specimens from the Biodiversity Exploratories plots or regions.
#'
#'   This function requires valid credentials for the Biodiversity Exploratories
#'   Information System (BExIS)!
#'
#' @param x A traitdata table of class 'traitdata'.
#' @param plots Name of column containing the plot IDs. Must match the Exploratories EP_PlotID scheme (e.g. AEG1, AEG12, HEW21, ...).
#' @param ... If input is a rawdata table of type species-trait matrix or
#'   occurence table (wide table) then provide parameters according to
#'   `as.traitdata()`.
#' @param user User name for Biodiversity Exploratories Information System
#'   (BExIS, https://www.bexis.uni-jena.de); required for download of exact
#'   geolocation.
#' @param pswd password for above request. Will be prompted for if not provided.
#' @param fillall if TRUE (default), the output will contain all terms suggested
#'   by the glossary and fill empty columns with NA. This is required for an
#'   upload of the data to BExIS.
#'
#' @return std
#' @export
#'
#' @import getPass
#' @examples
#'
#' \dontrun{
#' moths <- read.service(21247, dec = ",")
#'
#' dataset1 <- as.traitdata(moths, taxa = "species", traits = c(body_mass =
#'     "weight", wing_length = "wing_length", wing_width = "wing_width", wing_area =
#'     "wing_area", wing_loading = "wing_loading"),
#'   keep = c(locationID = "plot"))
#'
#' dataset1Std <- standardize.exploratories(dataset1)
#' }

standardize.exploratories <- function(x,
                        plots = "locationID",
                        user = NULL,
                        pswd = NULL,
                        fillall = TRUE, 
                        ..., 
                        verbose = NULL,
                        warnings = NULL) {
  
  if("data.frame" %in% class(x) && ! "traitdata" %in% class(x) ) x <- as.traitdata(x,...)
  
  if(is.null(user)) user <- readline("BExIS user name: ") 
  if(is.null(pswd)) pswd <- getPass::getPass("BExIS password: ", noblank = FALSE)
  
  #basic <- read.service(1000, user = user, pswd = pswd) # trying to access open data with rounded location data; but no webservice is supported.
  basic_ep <- read.service(20826, user = user, pswd = pswd)
  gridplots <- read.service(20907, user = user, pswd = pswd)
  
  rm(user, pswd)
  
  EP_valid <- levels(basic_ep$EP_PlotID)
  Region_valid <- c("HAI", "ALB", "SCH")
  
  request <- unique(x[,plots])
  
  GP_vec <- basic_ep$PlotID[match(request, EP_valid)] 
  temp <- gridplots[match(GP_vec, gridplots$Plot_ID) , c("Plot_ID", "Exploratory", "Landuse", "Longitude_Dec_Plotcenter", "Latitude_Dec_Plotcenter")]
  temp$ExploratoriesPlotID <- request
  temp$OriginExploratories <- TRUE
  temp$habitat <- c("forest", "grassland")[temp$Landuse]
  temp$elevation <-  as.numeric(sub(",", ".", basic_ep$Elevation[match(request, basic_ep$EP_PlotID)]))
  temp$geodeticDatum <- "WGS84"
  temp$verbatimLocality <- basic_ep$LocalName[match(request, basic_ep$EP_PlotID)]
  temp$country <- "Germany"
  temp$countryCode <- "DE"
  

  names(temp)[c(4:5,3)] <- c("decimalLongitude", "decimalLatitude", "ExploType")  
  
  
  out <- merge(x, subset(temp, select = -c(Plot_ID)), by.x = plots, by.y = "ExploratoriesPlotID")
  names(out)[1] <- "ExploratoriesPlotID"
  
  if(fillall) {
    # add all glossary terms to table and fill empty ones with NA
    
  glossarynames <- as.data.frame(t(data.frame(glossary$columnName, row.names = glossary$columnName)))[0,]
  out <- data.table::rbindlist(list(glossarynames, out), fill = TRUE)
  
  } else {
    
    # sort columns according to glossary of terms
    out <- out[, order(match(names(out), glossary$columnName) )]
    
  }
  
  # keep attributes of x
  attribs <- attributes(x)
  attribs$names <- attributes(out)$names
  attributes(out) <- attribs
  attr(out, "exploratories") <- temp
  
  return(out)
}
