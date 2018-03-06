# Autoinstallr 🤖

Automatically installs missing packages loaded with `library`.

## Overview

Overrides `base::library` with a library function that automatically installs missing packages. Uses RStudio's redirection servers as the repository URL.

Note `autoinstallr::library` has the same API and behavior as `base::library`.

```{r}
install_github('fny/autoinstallr')
library(autoinstallr)
library(library_thats_not_installed)
# => Installs and loads library_thats_not_installed
```

## Wishlist

 - Create a similar wrapper for `base::require`
 - Respect `getOption('repos')`
