library(autoinstallr)
context('autoinstaller tests')

#
# Helpers
#

is_installed <- function(package_name) {
  package_name %in% installed.packages()[,'Package']
}

is_loaded = function(package_name) {
  paste0('package:', package_name) %in% search()
}

ensure_removed = function(package_name) {
  if (is_loaded(package_name)) {
    detach(
      paste0('package:', package_name), unload = TRUE, character.only = TRUE
    )
  }
  if (is_installed(package_name)) {
    remove.packages(package_name)
  }
}

#
# Tests
#

test_that("overrides existing library function", {
  library.env = environment(library)
  expect_equal(environmentName(library.env), 'autoinstallr')
})

test_that("installs a package if it doesn't exist and requires it", {
  ensure_removed('RUnit')
  library.env = environment(library)
  expect_equal(environmentName(library.env), 'autoinstallr')
  library(RUnit)
  expect_true(is_installed('RUnit'))
  expect_true(is_loaded('RUnit'))
  ensure_removed('RUnit')
  expect_false(is_installed('RUnit'))
  expect_false(is_loaded('RUnit'))
})

test_that("requires a package if it's installed", {
  ensure_removed('RUnit')
  install.packages('RUnit')
  expect_true(is_installed('RUnit'))
  expect_false(is_loaded('RUnit'))
  library(RUnit)
  expect_true(is_loaded('RUnit'))
  ensure_removed('RUnit')
})

test_that("works with characters", {
  ensure_removed('RUnit')
  library.env = environment(library)
  expect_equal(environmentName(library.env), 'autoinstallr')
  library('RUnit', character.only = TRUE)
  expect_true(is_installed('RUnit'))
  expect_true(is_loaded('RUnit'))
  ensure_removed('RUnit')
  expect_false(is_installed('RUnit'))
  expect_false(is_loaded('RUnit'))
})

test_that("throws an error if installation fails", {
  ensure_removed('RUnit')
  with_mock(
    `base::install.packages` = function(...) { TRUE },
    expect_error(library(RUnit))
  )
})
