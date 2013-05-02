\name{compas}
\alias{compas}
\title{Simulation of species community data along gradients}

\description{The function generates unimodal curves of different shapes according to the specification of different parameter values. For different combinations of parameters, the response function may resemble the Gaussian curve or its skewed and platykurtic variations. Simulated observations are obtained by generating values for parameters and solving the function for defined x-values. In an ecological context, the response curve may be interpreted as densities of a species along an environmental gradient. Solving the function for a given x-value would be equivalent to sampling the species at the coordinate x. If many different curves are generated, solving the function for a given x-value would be equivalent to sampling a community at the coordinate x of the gradient. The idea is easily expanded to include two or more gradients or dimensions. For the case of two gradients, two sets of coordinates, one for each dimension, are used to obtain a community observation. A theory justifying the use of response curves along gradients and a discussion of the shapes of these curves is found in McGill & Collins (2003). The code is mostly based on Minchin (1987a, 1987b).}

\usage{
compas(S, dims, Am, beta, coords, n.quali, add1)}

\arguments{
  \item{S }{The number of species occurring in the simulated gradients. This IS NOT necessarily the number of species that will appear in the resulting dataset as some species may no be "sampled".}
  \item{dims }{Number of gradients (dimensions).} 
  \item{Am }{A vector of abundance of species in its modal point (log scale) for each gradient. This(ese) value(s) is(are) used as mean(s) to sample a lognormal distribution with mean \code{Am} and sd=1. The number of supplied means should be the same of the number of \code{dims}.}
  \item{beta }{Beta diversity (turnover) parameter.}
  \item{coords }{A matri-like object with coordinates of sampling sites. The number of columns (axes) should be the same of the number of \code{dims}.}
  \item{n.quali }{Qualitative Noise. Each specie has probability "1-n.quali" of occurring in a site within its range. The argument control the replacement of \code{n.quali}*100\% of the abundance values by "0".}
  \item{add1 }{A value between 0 and 1. Add (\code{add1}*100)\% of "marginal/vagrant species" occurring randomly with 1 individual in the entire dataset.}
}

\details{
This implementation is based on the software Compas (Minchin 1987b), described in detail in Minchin (1987a). Simulated parameters are random values obtained from distributions such as the normal and the uniform. Some of these parameters can be modified by users. However, some them are fixed and not modified unless you are able to edit the code. The option to fix some of the parameters should simplify the use of the function.

The number of species in the simulated matrix may be smaller than \code{S} because some species may occur outside the gradient. The gradiente is -50 up to 150, but 'sampling' occurs only at the range 0-100. This allows species to have their mode outside the 0-100 gradient. Also, species occrring in the gradient may not be sampled as a result of the qualitative (\code{n.quali}) and quantitative noises added.

Parameters alpha and gamma (not available as arguments), which together determine curve symmetry and kurtosis, are obtained from a uniform distribution bounded by 0.1 and 5. 

The abundance at the mode of the curve is determined by random values otained from log-normal distribution with log(mean) \code{Am} and  sd=1 (the last one not available as argument). 

The position of the modal point in the gradient, parameter m (not available as argument), is obtained from a random uniform distribution bounded by -50 and +150. For a studied gradient bounded by 0 and 100, the specification of a larger interval allows the position of the modal point to be located outside the gradient. 

The parameter \code{beta} determines the range of occurrence of a given species in the gradient. In terms of diversity, it determines the turnover (beta diversity) along the gradient, and is expressed as R units, where R = 100/mean(r), and r are the ranges of species. Values of r are obtained from a normal distribution with mean 100*R and standard deviation of 0.3*100*R (the last one not available as argument).

Species may be i) absent or ii) present in densities different from the expected due to sampling error, historical factors, or the influence of a multitude of environmental factors. Simulated communities are subject to these two types of errors or noise to mimic the two phenomena. The first phenomenon is achieved by randomly choosing \code{n.quali}*100% of non-zero values and replacing them by zeros. In order to obtain scattered values of abundances for each species along their gradients, each non-zero value is replaced by a random value obtained from a Poisson distribution with mean and variance (the lambda parameter) equal to the value to be replaced.

A third phenomenon commonly seen in field datasets is the occurrence of a species outside its regular range or in different habitats. These species are termed vagrant or marginal, and usually appear in the dataset with 1 individual. In order to account for this common finding, the function attaches to the simulated community an additional set of species with 1 individual, each species occurring in one sample unit only. The number of these additional species is set as \code{add1}*100% of the number of species sampled in the simulated communities after the inclusion of the two types of errors cited above.
}

\value{A dataframe of species (cols) abundances by sites (rows). In case of \code{dims=1}, a plot of response species curves is produced. These curves do not include qualitative noise (\code{n.quali}), quantitative noise (see comments above) and 'marginal/vagrant species' (\code{add1}) additions. 
}

\references{
McGill, B. & C. Collins. 2003. A unified theory for macroecology based on spatial patterns of abundance. Evolutionary Ecology Research 5: 469-492.

Minchin, P.R. 1987a. Simulation of multidimensional community patterns: towards a comprehensive model. Vegetatio 71: 145-156.

Minchin, P.R. 1987b. COMPAS: a program for the simulation of multidimensional community patterns based on generalized beta functions. Dep. of Biological Sciences, Southern Illinois University Edwardsville, USA.
}

\author{Adriano Sanches Melo}

\seealso{\code{\link[vegan]{vegdist}}}

\note{As the function includes many parameters, many simulated communities will not mimic the real ones. Users should try different set of options to approxiamte real datasets. A start point may be the two examples provided below.
}

\examples{
# 1 dimension
coo<-c(10,20,30,40,50,60,70,80,90)
coo<-as.matrix(coo)
compas(S=30, dims=1, Am=2, beta=1, coords=coo, n.quali=0.3, add1=0.1)
	
# 2 dimensions
coo2<-cbind(coo, coo)
compas(S=30, dims=2, Am=c(2,2), beta=c(2,2), coords=coo2, n.quali=0.3, add1=0.1)
}