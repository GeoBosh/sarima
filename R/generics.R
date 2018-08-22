## 2018-08-10 Moving the definition of =nSeasons()=  from package "sarima" to "lagged"
## 2017-06-02 Moving the definition of =nSeasons()=  from package "pcts" to "sarima"
## 2018-08-21 now this are imported from package lagged (>= 0.2):
## 2018-08-21 For the time being create them here, since
##     lagged 0.2-0 failed to export nSeasons() and nSeasons<-()
## 2018-08-22 delay uncommenting to upload the update regarding 'Makefiles'.
##   This is the entry for NEWS:
##      * `nSeasons()` and `nSeasons<-()`are now imported from package lagged.
## setGeneric("nSeasons", def = function(object){ standardGeneric("nSeasons") } )
## setGeneric("nSeasons<-", def = function(object, ..., value){ standardGeneric("nSeasons<-") } )
