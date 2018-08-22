## 2018-08-10 Moving the definition of =nSeasons()=  from package "sarima" to "lagged"
## 2017-06-02 Moving the definition of =nSeasons()=  from package "pcts" to "sarima"
## 2018-08-21 now this are imported from package lagged (>= 0.2):
## 2018-08-21 For the time being create them here, since
##     lagged 0.2-0 failed to export nSeasons() and nSeasons<-()
setGeneric("nSeasons", def = function(object){ standardGeneric("nSeasons") } )
setGeneric("nSeasons<-", def = function(object, ..., value){ standardGeneric("nSeasons<-") } )
