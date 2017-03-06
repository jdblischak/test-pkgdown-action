context("vig-getting-started")

# Testing similar workflow as in getting-started vignette

library("git2r")

# start project in a tempdir
site_dir <- tempfile("new-")
suppressMessages(wflow_start(site_dir, change_wd = FALSE))
r <- repository(path = site_dir)

test_that("wflow_start provides necessary infrastructure", {
  expect_true(dir.exists(file.path(site_dir, ".git")))
  expect_true(dir.exists(file.path(site_dir, "analysis")))
  expect_true(file.exists(file.path(site_dir, "analysis/_site.yml")))
  expect_true(file.exists(file.path(site_dir, "analysis/index.Rmd")))
  expect_true(file.exists(file.path(site_dir,
                                    paste0(basename(site_dir), ".Rproj"))))
  expect_true(length(commits(r)) == 1)
})

rmd_files <- list.files(path = file.path(site_dir, "analysis"),
                        pattern = "^[^_].*Rmd$",
                        full.names = TRUE)
stopifnot(length(rmd_files) > 0)
# Expected html files
html_files <- stringr::str_replace(rmd_files, "Rmd$", "html")
html_files <- stringr::str_replace(html_files, "/analysis/", "/docs/")

test_that("wflow_build builds the website, but only once", {
  output <- capture.output(built_files <- wflow_build(path = site_dir))
  expect_identical(rmd_files, built_files)
  expect_true(all(file.exists(html_files)))
  expect_message(wflow_build(path = site_dir),
                 "All HTML files have been rendered")
})

test_that("wflow_view opens website.", {
  expected <- file.path(site_dir, "docs/index.html")
  actual <- wflow_view(dry_run = TRUE, path = site_dir)
  expect_identical(actual, expected)
})

test_rmd <- file.path(site_dir, paste0("analysis/first-analysis.Rmd"))
file.copy("files/workflowr-template.Rmd", test_rmd)
# Expected html file
test_html <- stringr::str_replace(test_rmd, "Rmd$", "html")
test_html <- stringr::str_replace(test_html, "/analysis/", "/docs/")


test_that("wflow_open sets correct working directory", {
  cwd <- getwd()
  on.exit(setwd(cwd))
  wflow_open(files = basename(test_rmd), change_wd = TRUE,
             open_file = FALSE, path = site_dir)
  expect_identical(getwd(), dirname(test_rmd))
})

test_that("wflow_build only builds new file", {
  html_mtime_pre <- file.mtime(html_files)
  output <- capture.output(built_files <- wflow_build(path = site_dir))
  expect_identical(test_rmd, built_files)
  expect_true(file.exists(test_html))
  html_mtime_post <- file.mtime(html_files)
  expect_identical(html_mtime_pre, html_mtime_post)
  expect_message(wflow_build(path = site_dir),
                 "All HTML files have been rendered")
})

test_that("wflow_view can open specific file with Rmd extension & without path.", {
  expected <- file.path(site_dir, "docs/first-analysis.html")
  actual <- wflow_view("first-analysis.Rmd", dry_run = TRUE, path = site_dir)
  expect_identical(actual, expected)
})

all_rmd <- sort(c(test_rmd, rmd_files))
all_html <- sort(c(test_html, html_files))
test_that("wflow_commit can commit new file and website", {
  html_mtime_pre <- file.mtime(all_html)
  output <- capture.output(
    built_files <- wflow_commit(commit_files = test_rmd,
                                commit_message = "first analysis",
                                path = site_dir))
  expect_identical(all_rmd, built_files)
  expect_true(all(file.exists(all_html)))
  html_mtime_post <- file.mtime(all_html)
  expect_true(all(html_mtime_pre < html_mtime_post))
  log <- commits(r)
  # browser()
  expect_true(length(log) == 3)
  expect_identical(log[[1]]@message, "Build site.")
  expect_identical(log[[2]]@message, "first analysis")
  expect_message(wflow_commit(path = site_dir),
                 "Everything up-to-date")
})

unlink(site_dir, recursive = TRUE)