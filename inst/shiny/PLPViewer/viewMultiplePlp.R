viewMultiplePlp <- function (analysesLocation){
  viewPlps(result = analysesLocation, validation = NULL, useDatabase = F, 
           usePlpObject = F, useFileSystem = T)
}


viewPlps <- function (result, validation = NULL, useDatabase = NULL, usePlpObject = NULL, 
                      useFileSystem = NULL) 
{
  ensure_installed("shiny")
  ensure_installed("shinydashboard")
  ensure_installed("shinycssloaders")
  ensure_installed("DT")
  ensure_installed("htmlwidgets")
  ensure_installed("shinyWidgets")
  ensure_installed("plotly")
  appDir <- "./"
  shinySettings <- list(result = result, validation = validation, 
                        useDatabase = useDatabase, usePlpObject = usePlpObject, 
                        useFileSystem = useFileSystem)
  .GlobalEnv$shinySettings <- shinySettings
  on.exit(rm(shinySettings, envir = .GlobalEnv))
  shiny::runApp(appDir)
}

ensure_installed <- function (pkg) 
{
  if (!is_installed(pkg)) {
    msg <- paste0(sQuote(pkg), " must be installed for this functionality.")
    if (interactive()) {
      message(msg, "/nWould you like to install it?")
      if (utils::menu(c("Yes", "No")) == 1) {
        if (pkg %in% c("BigKnn", "IterativeHardThresholding")) {
          dvtCheck <- tryCatch(utils::packageVersion("devtools"), 
                               error = function(e) NA)
          if (is.na(dvtCheck)) {
            utils::install.packages("devtools")
          }
          devtools::install_github(paste0("OHDSI/", 
                                          pkg))
        }
        else {
          utils::install.packages(pkg)
        }
      }
      else {
        stop(msg, call. = FALSE)
      }
    }
    else {
      stop(msg, call. = FALSE)
    }
  }
}

is_installed <- function (pkg, version = 0) 
{
  installed_version <- tryCatch(utils::packageVersion(pkg), 
                                error = function(e) NA)
  !is.na(installed_version) && installed_version >= version
}

