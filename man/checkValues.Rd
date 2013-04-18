\name{checkValues}
\alias{checkValues}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
checkValues(names = NULL, values = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{names}{
%%     ~~Describe \code{names} here~~
}
  \item{values}{
%%     ~~Describe \code{values} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (names = NULL, values = NULL) 
{
    if (!is.null(names) & !is.null(values)) {
        if (length(names) != length(values)) {
            stop("There seems to be an error in the submission correctness test. Please contact the course creator.")
        }
        to.print = equal = NULL
        for (i in 1:length(names)) {
            if (is.na(values[i])) {
                equal[i] <- is.na(names[i])
            }
            else {
                equal[i] <- names[i] == values[i]
            }
            if (!equal[i]) {
                to.print <- paste("Did you set the value of the variable", 
                  names[i], " equal to:", values[i], "? ")
            }
        }
        if (any(!equal)) {
            return(list(FALSE, to.print))
        }
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
