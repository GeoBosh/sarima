// #include <Rcpp.h>
#include <RcppArmadillo.h>

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
arma::mat arma_Q0gnb0(const arma::colvec & phi, const arma::colvec & theta,
		     double tol = 2.220446e-16) {
  const int p = phi.size();
  const int q = theta.size();
  const int r = (p >= q + 1) ? p : q + 1;

  arma::mat res(r, r, fill::zeros);

  if(r == 1){ // q = 0;  p = 0 or 1 here
    res(0, 0) = (p == 1) ? 1/(1 - pow(phi[0],2)) : 1.0;
    return(res);
  }

  arma::colvec b(r, fill::zeros);
  // expand phi with zeroes and work with rphi below (instead of phi)
  //   there may be scope for improved efficiency here.
  arma::colvec rphi = b;
  if(p > 0)
    rphi(span(0, p - 1)) = phi;
  
  arma::colvec onetheta(r, fill::zeros);
  onetheta(0) = 1;
  if(q > 0)
    onetheta(span(1, q)) = theta;
  
  arma::mat Sigma = onetheta * onetheta.t();
  arma::mat A = arma::eye(r, r);
  
  for(int k = 1; k <= r; ++k){
    b[k - 1] = Sigma(0, k - 1);
    A(k - 1, 1) = A(k - 1, 1) - rphi[k - 1];
    double ak1 = rphi[r - k] * rphi[k + (r - k + 1) - 1 - 1];
    if(k < r){
      for(int i = 1; i <= r - k; ++i){
	b[k - 1] = b[k - 1] + Sigma(i, k + i - 1);
	A(k - 1, k + i - 1) = A(k - 1, k + i - 1) - rphi[i - 1];
	if(2 + i <= r)
	  A(k - 1, 2 + i - 1) = A(k - 1, 2 + i - 1) - rphi[k + i - 1];
	ak1 = ak1 + rphi[i - 1] * rphi[k + i - 1 - 1];
      }
    }
    A(k - 1, 0) = A(k - 1, 0) - ak1;
  }

  arma::colvec g1 = solve(A, b);

  res(0, span::all) = g1.t();
  res(r - 1, r - 1) = pow(rphi[r - 1], 2) * g1[0] + Sigma(r - 1, r - 1);
  if(r > 2){
    for(int i = r - 1; i >= 2; --i){
      res(i - 1, r - 1) = rphi[i - 1] * rphi[r - 1] * g1[0] + rphi[r - 1] * g1[i] +
	Sigma(i - 1, r - 1);
      for(int j = r-1; j >= i; --j){
	res(i - 1, j - 1) = rphi[i - 1] * rphi[j - 1] * g1[0] + rphi[i - 1] * g1[j] +
	  rphi[j - 1] * g1[i] + Sigma(i - 1, j - 1) + res(i, j);
      }
    }
  }

  // r > 1 here, so we don't check this
  res(1, 0) = res(0, 1);
  if(r > 2){
    for(int i = 1; i <= r - 1; ++i)
      for(int j = i + 1; j <= r; ++j)
	res(j - 1, i - 1) = res(i - 1, j - 1);
  }
  
  return res;
}


// [[Rcpp::export]]
arma::mat arma_Q0gnb(const arma::colvec & phi, const arma::colvec & theta,
		    const double tol = 2.220446e-16) {
  const int p = phi.size();
  const int q = theta.size();
  const int r = (p >= q + 1) ? p : q + 1;

  arma::mat res(r, r, fill::zeros);

  if(r == 1){ // q = 0;  p = 0 or 1 here
    res(0, 0) = (p == 1) ? 1/(1 - pow(phi[0],2)) : 1.0;
    return(res);
  }

  arma::colvec b(r, fill::zeros);
  // expand phi with zeroes and work with rphi below (instead of phi)
  //   there may be scope for improved efficiency here.
  arma::colvec rphi = b;
  if(p > 0)
    rphi(span(0, p - 1)) = phi;
  
  arma::colvec onetheta(r, fill::zeros);
  onetheta(0) = 1;
  if(q > 0)
    onetheta(span(1, q)) = theta;
  
  arma::mat Sigma = onetheta * onetheta.t();
  arma::mat A = arma::eye(r, r);
  
  // for(int k = 1; k <= r; ++k){
  //   b[k - 1] = Sigma(0, k - 1);
  //   A(k - 1, 1) -= rphi[k - 1];
  //   double ak1 = rphi[r - k] * rphi[k + (r - k + 1) - 1 - 1];
  //   if(k < r){
  //     for(int i = 1; i <= r - k; ++i){
  // 	b[k - 1] +=  Sigma(i, k + i - 1);
  // 	A(k - 1, k + i - 1) -=  rphi[i - 1];
  // 	if(2 + i <= r)
  // 	  A(k - 1, 2 + i - 1) -= rphi[k + i - 1];
  // 	ak1 += rphi[i - 1] * rphi[k + i - 1 - 1];
  //     }
  //   }
  //   A(k - 1, 0) -= ak1;
  // }

  for(int k = 0; k < r; ++k){
    b[k] = Sigma(0, k);
    A(k, 1) -= rphi[k];
    double ak1 = rphi[r - (k + 1)] * rphi[k + (r - k) - 1];
    if(k < r - 1){
      for(int i = 1; i <= r - (k + 1); ++i){
	b[k] +=  Sigma(i, k + i);
	A(k, k + i) -=  rphi[i - 1];
	if(2 + i <= r)
	  A(k, 2 + i - 1) -= rphi[k + i];
	ak1 += rphi[i - 1] * rphi[k + i - 1];
      }
    }
    A(k, 0) -= ak1;
  }

  arma::colvec g1 = solve(A, b);

  res(0, span::all) = g1.t();
  res(r - 1, r - 1) = pow(rphi[r - 1], 2) * g1[0] + Sigma(r - 1, r - 1);
  if(r > 2){
    for(int i = r - 1; i >= 2; --i){
      res(i - 1, r - 1) = rphi[i - 1] * rphi[r - 1] * g1[0] + rphi[r - 1] * g1[i] +
	Sigma(i - 1, r - 1);
      for(int j = r - 1; j >= i; --j){
	res(i - 1, j - 1) = rphi[i - 1] * rphi[j - 1] * g1[0] + rphi[i - 1] * g1[j] +
	  rphi[j - 1] * g1[i] + Sigma(i - 1, j - 1) + res(i, j);
      }
    }
  }
  
  if(r > 1){
    res(1, 0) = res(0, 1);
    if(r > 2){
      for(int i = 0; i < r - 1; ++i)
	for(int j = i + 1; j < r; ++j)
	  res(j, i) = res(i, j);
    }
  }
  
  return res;
}
