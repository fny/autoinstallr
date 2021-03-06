% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autoinstallr.R
\name{library}
\alias{library}
\title{Wrapper around base R's library function which also installs missing packages
and loads them. Uses the https://cloud.r-project.org/ redirect URL to access
CRAN.}
\usage{
library(package, help = NULL, pos = 2, lib.loc = NULL,
  character.only = FALSE, logical.return = FALSE, warn.conflicts = TRUE,
  quietly = FALSE, verbose = getOption("verbose"))
}
\description{
Arguments match those of base::library.
}
