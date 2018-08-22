\name{modelCoef}
\alias{modelCoef}
\title{Get the coefficients of models}
\description{
  Get the coefficients of an object, optionally specifying
  the expected format.
}
\usage{
modelCoef(object, convention, component, ...)
}
\arguments{
  \item{object}{an object.}
  \item{convention}{
    the convention to use for the return value, a character string or any
    object from a supported class, see Details.
  }
  \item{component}{
    if not missing, specifies a component to extract, see Details.
  }
  \item{\dots}{not used, further arguments for methods.}
}
\details{

  \code{modelCoef} is a generic function for extraction of coefficients
  of model objects. What `coeffcients' means depends on the class of
  \code{object} but it can be changed with the optional argument
  \code{convention}. In effect, \code{modelCoef} provides a very
  flexible and descriptive way of extracting coefficients from models in
  various forms.

  The one-argument form, \code{modelCoef(object)}, gives the
  coefficients of \code{object}. In effect, it defines the meaning of
  `coefficients' for the purposes of \code{modelCoef}.

  Argument \code{convention} can be used to specify what kind of value
  to return.

  If \code{convention} is not a character string, only its class is
  used. Conceptually, the value will have the format and meaning of the
  value that would be returned by a call to \code{modelCoef(obj)} with
  \code{obj} from class "convention".

  If \code{convention} is a character string, it is typically the name
  of a class. In this case \code{modelCoef(object, "someclass")} is
  equivalent to \code{modelCoef(object, new("someclass"))}.
  Note that this is conceptual - argument
  \code{convention} can be the name of a virtual class, for example.
  Also, for some classes of \code{object} character values other than
  names of classes may be supported.

  For example, if \code{obj} is from class "ArmaModel",
  \code{modelCoef(obj)} returns a list with components "ar" and "ma",
  which follow the "BD" convention. So, to get such a list of
  coefficients from an \code{object} from any class capable of
  representing ARMA models, set \code{convention = "ArmaModel"} in the
  call to \code{modelCoef{}}.

  \code{modelCoef()} will signal an error if \code{object} is not
  compatible with \code{target} (e.g. if it contains unit roots).
  (see \code{filterCoef} if you need to expand any multiplicative
  filters).

  If there is no class which returns exactly what is needed some
  additional computation may be necessary. In the above
  "ArmaModel" example we might need the coefficients in the "BJ"
  convention, so we would need to change the signs of the MA
  coefficients to achieve this. Since this is a very common operation,
  a convenience feature is available. Setting \code{convention = "BJ"}
  requests ARMA coefficients with "BJ" convention. For completeness, the
  the settings "SP" (signal processing) and "BD" (Brockwell-Davis) are
  also available.

  The methods for \code{modelCoef()} in package "sarima" return a list
  with components depending on argument "convention", as outlined
  above.

}
\value{
  a list, with components depending on the target class, as described in
  Details
}
% \references{
% %% ~put references to the literature/web site here ~
% }
\author{Georgi N. Boshnakov}
% \note{
% %%  ~~further notes~~
% }
%
% %% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  code{\link{modelOrder}}
}
% \examples{
% }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ts}
% use one of  RShowDoc("KEYWORDS")
