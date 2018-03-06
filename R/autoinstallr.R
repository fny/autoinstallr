#' Checks whether a package is installed
is_installed = function(package_name) {
  package_name %in% installed.packages()[,'Package']
}

#' Installs a package if missing
install_if_missing = function(package_name, quietly = FALSE) {
  # Stop if we're trying to reload ourself
  if (package_name == 'autoinstallr') {
    return()
  }

  # If the package isn't installed, install it
  if (!is_installed(package_name)) {
    if (!quietly) message('Attempting to install ', package_name)
    install.packages(package_name,  repos = 'https://cloud.r-project.org/')
  }

  # If the package still isn't installed, throw an error
  if (!is_installed(package_name)) {
    stop(
      paste0(
        package_name,
        " failed to install. Check previous messages and logs to see what might have happened."
      )
    )
  }
}

#' Wrapper around base R's library function which also installs missing packages
#' and loads them. Uses the https://cloud.r-project.org/ redirect URL to access
#' CRAN.
#'
#' Arguments match those of base::library.
#'
#' @export
library = function(package, help = NULL, pos = 2, lib.loc = NULL,
                   character.only = FALSE, logical.return = FALSE,
                   warn.conflicts = TRUE, quietly = FALSE,
                   verbose = getOption('verbose')) {

  if (character.only) {
    package_name = package
  } else {
    package_name = deparse(substitute(package))
  }

  install_if_missing(package_name, quietly)

  # Load the library with the provided arguments
  base::library(
    eval(package_name), help, pos, lib.loc,
    character.only = TRUE, logical.return,
    warn.conflicts, quietly, verbose
  )
}
