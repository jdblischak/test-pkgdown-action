% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wflow_toc.R
\name{wflow_toc}
\alias{wflow_toc}
\title{Create table of contents}
\usage{
wflow_toc(
  ignore_nav_bar = TRUE,
  clipboard = TRUE,
  only_published = TRUE,
  project = "."
)
}
\arguments{
\item{ignore_nav_bar}{logical (default: TRUE). Ignore any HTML files included
as links in the navigation bar.}

\item{clipboard}{logical (default: TRUE) Attempt to copy table of contents to
clipboard. Only relevant if
\href{https://cran.r-project.org/package=clipr}{clipr} package is installed
and the system keyboard is available.}

\item{only_published}{logical (default: TRUE) Include only published contents.}

\item{project}{character (default: ".") By default the function assumes the
current working directory is within the project. If this is not true,
you'll need to provide the path to the project directory.}
}
\value{
Invisibly returns the table of contents as a character vector.
}
\description{
\code{wflow_toc} creates a table of contents of the published R Markdown
files. The output is in markdown format, so you can paste it into a document
such as \code{index.Rmd}. If the R package
\href{https://cran.r-project.org/package=clipr}{clipr} is installed, the
table of contents is copied to the clipboard. Otherwise the output is sent to
the R console.
}
\details{
The default behavior is to attempt to copy the table of contents to the
clipboard for easy pasting into an R Markdown document. If this isn't working
for you, you can try the following:

\itemize{

\item Check that the clipr package is installed:
\code{install.packages("clipr")}

\item Check that the system keyboard is writable. Run
\code{\link[clipr]{clipr_available}} and \code{\link[clipr:clipr_available]{dr_clipr}}.

\item If it's still not working, set \code{clipboard = FALSE} to send the
table of contents to the R console to manually copy-paste.

}
}
