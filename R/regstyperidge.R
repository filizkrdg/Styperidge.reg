
#' Full regression results using the stype robust ridge regression estimators
#'
#' @name regstyperidge
#'
#' @description Full regression results using the stype robust ridge regression estimators
#'
#' @param x Explanatory variables (Dataframe, matrix)
#' @param y Dependent variables (Dataframe, vector)

#'
#' @return A list of lists
#' @export
#' 
#' @import isdals
#' @import mctest
#' @import ridgregextra
#' @import Stype.est

#'
#' @examples
#' library("mctest")
#' x <- Hald[,-1]
#' y <- Hald[,1]
#' regstyperidge(x,y)
#'
#' library(isdals)
#' data(bodyfat)
#' x <- bodyfat[,-1]
#' y <- bodyfat[,1]
#'regstyperidge(x,y)


regstyperidge <- function(x,y) {   
  
  if (is.vector(x)){
    n=length(x); p=1
    x=matrix(x,ncol=1)
  } else {
    n=dim(x)[1]; p=dim(x)[2]
    if(p==1) {
      x=matrix(x[,1],ncol=1)
    } else {
      x=as.matrix(x)
    }
  }
  if (is.vector(y)) {
    y=matrix(y,ncol=1)
  } else {
    cy=dim(y)[2]
    if(cy==1) {
      y=matrix(y[,1],ncol=1)
    } else {
      y=as.matrix(y)
    }
  }
  
  stype = regstype(y,x)
  wstype = stype$W
  wstype <- as.vector(stype$W) 
  WeightedRidgeStype = Weightedridge.reg(x,y,wstype)
  
  z=list(
    betaStype = WeightedRidgeStype$beta,
    betaorStype = WeightedRidgeStype$betaor,
    eStype = WeightedRidgeStype$e,
    ewStype = WeightedRidgeStype$ew,
    yhatStype = WeightedRidgeStype$yhat,
    yhatwStype = WeightedRidgeStype$yhatw,
    MSEStype = WeightedRidgeStype$MSE,
    FStype = WeightedRidgeStype$F,
    sigStype = WeightedRidgeStype$sig,
    varbetaStype = WeightedRidgeStype$varbeta,
    stdbetaStype = WeightedRidgeStype$stdbeta,
    R2Stype = WeightedRidgeStype$R2,
    R2adjStype = WeightedRidgeStype$R2adj,
    anovatableStype = WeightedRidgeStype$anovatable,
    confintStype = WeightedRidgeStype$confint,
    weightorStype = wstype,
    ccStype = WeightedRidgeStype$cc
  )
  
  return(z)
}

