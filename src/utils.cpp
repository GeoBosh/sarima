// #include <Rcpp.h>
#include <RcppArmadillo.h>

using namespace Rcpp;
using namespace arma;

// T = T1 + T2 from Tunnicliffe-Wilson 1969
// [[Rcpp::export]]
arma::mat DAcvfWrtMA(const arma::vec & x) {
  int n = x.size();
  arma::vec rx = flipud(x);
  arma::mat T(n,n, fill::zeros);
  arma::mat T1(n,n, fill::zeros);
  arma::mat T2(T1);
  
  for(int k = 0, m = n - 1; k < n; ++k, --m) {
    T1.diag(k).fill(x[m]);
    T2.diag(k).fill(x[k]);  // or T.diag(k).fill += x[k]; but T.diag(k).fill += x[k] doesn't work
  }

  T2 += fliplr(T1);

  return(T2);
}

// [[Rcpp::export]]
NumericVector MAacvf0(const NumericVector & x) {
  int n = x.size();

  NumericVector acvf(n);

  for(int lag = 0; lag < n; ++lag) {
    double wrk = 0;
    for(int j = lag; j < n; ++j) {
      wrk += x[j] * x[j - lag];
    }
    acvf[lag] = wrk;
  }
  
  return(acvf);
}
