#' @title Periodogram function
#' @description This function computes the periodogram from a stationary time
#' serie. Returns the periodogram, its graph and the Fourier frequency.
#' @details
#' The tapered periodogram it is given by
#' \deqn{I(\lambda) = \frac{|D_n(\lambda)|^2}{2\pi
#' H_{2,n}(0)}} with \eqn{D(\lambda) = \sum_{s=0}^{n-1} h
#' \left(\frac{s}{N}\right) y_{s+1}\,
#' e^{-i\,\lambda\,s}}, \eqn{H_{k,n} = \sum_{s=0}^{n-1}h
#' \left(\frac{s}{N}\right)^k\,
#' e^{-i\,\lambda\,s}} and \eqn{\lambda} are Fourier frequencies defined as
#' \eqn{2\pi k/n}, with \eqn{k = 1,\,\ldots,\, n}.
#' The data taper used is the cosine bell function,
#' \eqn{h(x) = \frac{1}{2}[1-\cos(2\pi x)]}. If the series has missing data,
#' these are replaced by the average of the data and \eqn{n} it is corrected by
#' $n-N$, where \eqn{N} is the amount of missing values of serie. The plot of
#' the periodogram is \code{periodogram} values vs. \eqn{\lambda}.
#' @param y (type: numeric) data vector
#' @param plot (type: logical) logical argument which allows to plot the
#' periodogram. Defaults to TRUE.
#' @param include.taper (type: logical) logical argument which by default is
#' \code{FALSE}. If \code{include.taper=TRUE} then \code{y} is multiplied by
#' \eqn{0.5(1 - \cos(2\pi(n-1)/n))} (cosine bell).
#' @references
#' For more information on theoretical foundations and estimation methods see
#' \insertRef{brockwell2002introduction}{LSTS}
#' \insertRef{dahlhaus1997fitting}{LSTS}
#' @examples
#' # AR(1) simulated
#' set.seed(1776)
#' ts.sim <- arima.sim(n = 1000, model = list(order = c(1, 0, 0), ar = 0.7))
#' per <- periodogram(ts.sim)
#' per$plot
#' @return
#' A list with with the periodogram and the lambda values.
#' @seealso \code{\link[stats]{fft}}, \code{\link[base]{Mod}},
#' \code{\link[stats]{smooth.spline}}.
#' @importFrom stats fft
#' @importFrom ggplot2 geom_line
#' @importFrom scales math_format
#' @export
periodogram <- function(y, plot = TRUE, include.taper = FALSE) {
  series <- y - mean(y, na.rm = TRUE)
  N <- sum(is.na(series))
  series[is.na(series)] <- 0
  n <- length(series)
  if (include.taper == TRUE) {
    a <- 0.5 * (1 - cos(2 * pi * (0:(n - 1)) / n))
    series <- series * a
  }
  aux <- Mod(fft(series))^2
  m <- n / 2
  periodogram <- (aux[2:(m + 1)]) / (2 * pi * (n - N))
  if (include.taper == TRUE) {
    periodogram <- (aux[2:(m + 1)]) / (3 * pi * (n - N) / 4)
  }
  lambda <- (2 * pi * (1:m)) / n
  if (plot == TRUE) {
    pi_scales <- math_format(.x * pi, format = function(x) x / pi)
    g <- ggplot(data.frame(x = lambda, y = periodogram)) +
      geom_line(aes(x = as.numeric(x), y = as.numeric(y)), color = "#1f77b4") +
      labs(x = "Frequency", y = "Periodogram") +
      scale_x_continuous(labels = pi_scales, breaks = seq(0, pi, pi / 4)) +
      theme_minimal()
  } else {
    g <- NULL
  }
  return(list(periodogram = periodogram, lambda = lambda, plot = g))
}
