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
                        getdata = !is.null(user),
                        fillall = TRUE, 
                        ..., 
                        verbose = NULL,
                        warnings = NULL) {
  
  if("data.frame" %in% class(x) && ! "traitdata" %in% class(x) ) x <- as.traitdata(x,...)
  
  if(getdata) {
    
    if(is.null(user)) user <- readline("BExIS user name: ") 
    if(is.null(pswd)) pswd <- getPass::getPass("BExIS password: ", noblank = FALSE)
  
    #basic <- read.service(1000, user = user, pswd = pswd) # trying to access open data with rounded location data; but no webservice is supported.
    basic_ep <- read.service(20826, user = user, pswd = pswd)
    gridplots <- read.service(20907, user = user, pswd = pswd)
  
    rm(user, pswd)
    
    
    BEplots <- merge(subset(gridplots, select= c("Plot_ID", 
                                                 "Plotlevel", 
                                                 "Exploratory", 
                                                 "Landuse", 
                                                 "Longitude_Dec_Plotcenter", 
                                                 "Latitude_Dec_Plotcenter")
    ),
    subset(basic_ep, select = c("EP_PlotID", 
                                "PlotID", 
                                "VIP", 
                                "MIP", 
                                "LocalName", 
                                "SoilTypeWRB", 
                                "Elevation")
    ), 
    by.x = "Plot_ID", by.y = "PlotID", all.x = TRUE)
    
    names(BEplots) <- c("Plot_ID", "Plotlevel", "Exploratory", "BEType", 
                        "decimalLongitude", "decimalLatitude", "EP_PlotID", 
                        "VIP", "MIP", "verbatimLocality", "SoilTypeWRB", 
                        "elevation")
    
    
  }

    
  if(all(levels(x[,plots]) %in% BEplots$EP_PlotID0)) {
    temp <- subset(BEplots, EP_PlotID0 %in% x[,plots])
    temp$BEPlotID <- temp$EP_PlotID
    
    levels(x[,plots]) <- BEplots$EP_PlotID[match(x[,plots], BEplots$EP_PlotID0)]
    
  }
  
  if(all(levels(x[,plots]) %in% BEplots$EP_PlotID)) {
    temp <- subset(BEplots, EP_PlotID %in% x[,plots]) 
    temp$BEPlotID <- temp$EP_PlotID

  }
  
  if(all(levels(x[,plots]) %in% BEplots$Plot_ID)) {
    temp <- subset(BEplots, Plot_ID %in% x[,plots])
    temp$BEPlotID <- temp$Plot_ID
  } 
  
  temp$OriginBE <- TRUE
  temp$habitat <- c("forest", "grassland")[temp$BEType]
  temp$geodeticDatum <- "WGS84"
  temp$country <- "Germany"
  temp$countryCode <- "DE"
  
  
  out <- merge.data.frame(x, subset(temp, select = c(-Plot_ID, -Plotlevel, -EP_PlotID, -VIP, -MIP, -SoilTypeWRB, -EP_PlotID0)), 
               by.x = plots, by.y = "BEPlotID")
  names(out)[1] <- "BEPlotID"
  
  if(fillall) {
    # add all glossary terms to table and fill empty ones with NA
    
  colnames <- glossary$columnName[glossary$Namespace != "Traitlist"]
  glossarynames <- as.data.frame(t(data.frame(colnames, row.names = colnames)))[0,]
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
