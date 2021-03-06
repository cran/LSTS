% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/block_smooth_periodogram.R
\name{block.smooth.periodogram}
\alias{block.smooth.periodogram}
\title{Smooth Periodogram by Blocks}
\usage{
block.smooth.periodogram(
  y,
  x = NULL,
  N = NULL,
  S = NULL,
  p = 0.25,
  spar.freq = 0,
  spar.time = 0
)
}
\arguments{
\item{y}{(type: numeric) data vector}

\item{x}{(type: numeric) optional vector, if \code{x = NULL} then the
function uses \eqn{(1,\ldots,n)} where \code{n} is the length of \code{y}.}

\item{N}{(type: numeric) value corresponding to the length of the window to
compute periodogram.
If \code{N=NULL} then the function will use
\eqn{N = \textrm{trunc}(n^{0.8})}, see
\insertCite{dahlhaus1998optimal;textual}{LSTS} where \eqn{n} is the length of
the \code{y} vector.}

\item{S}{(type: numeric) value corresponding to the lag with which will be
taking the blocks or windows to calculate the periodogram.}

\item{p}{(type: numeric) value used if it is desired that \code{S} is
proportional to \code{N}. By default \code{p=0.25}, if \code{S} and \code{N}
are not entered.}

\item{spar.freq}{(type: numeric) smoothing parameter, typically (but not
necessarily) in \eqn{(0,1]}.}

\item{spar.time}{(type: numeric) smoothing parameter, typically (but not
necessarily) in \eqn{(0,1]}.}
}
\value{
A ggplot object.
}
\description{
Plots the contour plot of the smoothing periodogram of a time series, by
blocks or windows.
}
\details{
The number of windows of the function is \eqn{m = \textrm{trunc}((n-N)/S+1)},
where \code{\link[base]{trunc}} truncates de entered value and \emph{n} is
the length of the vector \code{y}. All windows are of the same length
\code{N}, if this value isn't entered by user then is computed as
\eqn{N=\textrm{trunc}(n^{0.8})} (Dahlhaus).
\code{LSTS_spb} computes the periodogram in each of the
\emph{M} windows and then smoothes it two times with
\code{\link[stats]{smooth.spline}} function; the first time using
\code{spar.freq} parameter and the second time with \code{spar.time}. These
windows overlap between them.
}
\examples{
block.smooth.periodogram(malleco)
}
\references{
For more information on theoretical foundations and estimation methods see
\insertRef{dahlhaus1997fitting}{LSTS}
\insertRef{dahlhaus1998optimal}{LSTS}
}
\seealso{
\code{\link{arima.sim}}
}
