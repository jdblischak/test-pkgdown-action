% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wflow_html.R
\name{wflow_pre_processor}
\alias{wflow_pre_processor}
\title{pre_processor function for workflowr}
\usage{
wflow_pre_processor(
  metadata,
  input_file,
  runtime,
  knit_meta,
  files_dir,
  output_dir
)
}
\arguments{
\item{metadata}{The metadata specified in the YAML header of the R Markdown
file}

\item{input_file}{Name of Markdown file created by
\code{knitr::\link[knitr]{knit}} to be passed to
\href{https://pandoc.org/}{pandoc}}

\item{runtime}{The runtime target for rendering. The \code{static} option
produces output intended for static files; \code{shiny} produces output
suitable for use in a Shiny document (see \code{\link[rmarkdown]{run}}). The default,
\code{auto}, allows the \code{runtime} target specified in the YAML metadata
to take precedence, and renders for a \code{static} runtime target otherwise.}

\item{knit_meta}{(This option is reserved for expert use.) Metadata
generated by \pkg{knitr}.}

\item{files_dir}{Directory for saving intermediate files}

\item{output_dir}{The output directory for the rendered \code{output_file}.
This allows for a choice of an alternate directory to which the output file
should be written (the default output directory of that of the input file).
If a path is provided with a filename in \code{output_file} the directory
specified here will take precedence. Please note that any directory path
provided will create any necessary directories if they do not exist.}
}
\description{
This is the \code{pre_processor} function that \code{\link{wflow_html}}
passes to the function \code{\link[rmarkdown]{output_format}} from the
package \link{rmarkdown}. For advanced usage only.
}
\details{
If you'd like to combine workflowr with another R Markdown output format, you
may need to use \code{wflow_pre_processor}. This function only has minor
effects on the style of the resulting HTML page, and is not essential for
using workflowr.
}
\seealso{
\code{\link{wflow_html}}, \code{\link{wflow_pre_knit}},
         \code{\link{wflow_post_knit}}
}
\keyword{internal}
