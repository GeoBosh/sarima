// #include <Rcpp.h>
#include <RcppArmadillo.h>

using namespace Rcpp;
using namespace arma;

// Like uniKalmanLikelihood0a  but spans computed separately
//    (there may be some further minor changes too)
// [[Rcpp::export]]
List uniKalmanLikelihood0b(
			  const NumericVector & y, 
			  const List          &  mod,
			  const NumericVector & nit,
			  const LogicalVector & op,
			  const LogicalVector & update) {
  const arma::colvec & phi   = mod["phi"]  ;
  const arma::colvec & theta = mod["theta"];
  const arma::colvec & Delta = mod["Delta"];
  
  const arma::rowvec & Z  = as<arma::rowvec>(mod["Z"]);
  arma::colvec         a  = as<arma::colvec>(mod["a"]);
  arma::mat            P  = as<arma::mat>(mod["P"]);
  const arma::mat    & T  = as<arma::mat>(mod["T"]);
  const arma::mat    & V  = as<arma::mat>(mod["V"]);
  double               h  = as<double>(mod["h"]); // TODO: in general, h is a matrix
  arma::mat            Pn = as<arma::mat>(mod["Pn"]);

  int    nu = 0;
  double ssq = 0;
  double sumlog = 0;

  const bool useResid = op[0];
  // const bool useStates = useResid;
  
  const int sUP = nit[0];

  arma::mat Pnew = Pn;
  arma::mat Ptmp = Pn;

  const arma::mat    & Tt  = T.t();
  const arma::colvec & Zt  = Z.t();
  const arma::rowvec & phit  = phi.t();
  const arma::rowvec & Deltat  = Delta.t();
  
  const int n = y.size();  
  const int p = phi.size();
  const int q = theta.size();
  const int d = Delta.size();
  const int r = (p >= q + 1) ? p : q + 1;  // int r = max(p, q + 1);
  
  NumericVector gainVec(n); // 2018-08-23
  NumericVector rsResid(n);
  NumericMatrix states(n, r+d); // 2018-08-23 This nees more thought, 
                                //  for long time series it may be enourmous

  double gain;
  arma::colvec anew(r + d, fill::zeros);

  const span sp0Tpm1 = span(0, p - 1);
  const span sp1Trm1 = span(1, r - 1);
  const span sp0Trm2 = span(0, r - 2);
  const span sprTrpdm1 = span(r, r + d - 1);
  const span sprp1Trpdm1 = span(r + 1, r + d - 1);
  const span sprTrpdm2 = span(r, r + d - 2);
  // const span sp0Trpdm1 = span(0, r + d - 1);
  
  for (int l = 0; l < n; l++) {
    // anew = T * a;  // anew  = a(t|t-1)
    double a1 = (double) a[0];
    anew.fill(0.0);
    if(p > 0) anew(sp0Tpm1)  = phi * a1;
    if(r > 1) anew(sp0Trm2) += a(sp1Trm1);
    if(d > 0) anew[r] = a1 + as_scalar(Deltat * a(sprTrpdm1));
    if(d > 1) anew(sprp1Trpdm1) = a(sprTrpdm2);
    
    if(l > sUP){  // update Pnew = P[t|t -1]
      // Pnew = V + T * P * T';

      // T * P
      Ptmp.fill(0.0);
      if(p > 0) Ptmp(sp0Tpm1, span::all)    = phi * P(0, span::all );
      if(r > 1) Ptmp(sp0Trm2, span::all)   += P(sp1Trm1, span::all);
      if(d > 0)	Ptmp(r, span::all)          = T(r, span::all)  * P; // TODO: this line could be optimised somewhat
      if(d > 1) Ptmp(sprp1Trpdm1, span::all) = P(sprTrpdm2, span::all);

      // (T * P) * T'
      Pnew.fill(0.0);
      if(p > 0) Pnew(span::all, sp0Tpm1)     = Ptmp(span::all, 0) * phit;
      if(r > 1) Pnew(span::all, sp0Trm2)    += Ptmp(span::all, sp1Trm1);
      // if r > p the r-th row is zero (its index is r-1 in C++)
      if(d > 0)	Pnew(span::all, r)           = Ptmp * Tt(span::all, r);
      // the last d - 1 columns are obtained by shifting columns of Ptmp to the right
      if(d > 1) Pnew(span::all, sprp1Trpdm1) = Ptmp(span::all, sprTrpdm2);

      Pnew += V;
    }
    
    if (!NumericVector::is_na(y[l])){// or: if (arma::is_finite(y[l])){// but true also if NaN, Inf
      double resid = y[l] - arma::as_scalar(Z * anew);
      arma::mat M = Pnew * Zt;

      gain =  h + arma::as_scalar(Z * Pnew * Zt);
      if(gain < 1e4) {
	nu++;
	ssq += resid * resid / gain;
	sumlog += log(gain);
      }

      a = anew + M * resid / gain; // a is a(t|t)
      P = Pnew - M * M.t() / gain; // P is P(t|t)
       
     if (useResid){ // record residuals, standardised residuals, gain and state values
          rsResid[l] = resid / sqrt(gain); // only this was returned before v0.7-8 (2018-08-23)
          gainVec[l] = gain; 
          for(int i = 0; i < (r + d); i++)
              states(l,i) = a[i];
      } 
    }else{
      a = anew;
      P = Pnew;     
      if (useResid){
          rsResid[l] = NA_REAL; // only this was returned before v0.7-8 (2018-08-23)
          gainVec[l] = NA_REAL;
          for(int i = 0; i < (r + d); i++)
              states(l,i) = a[i];
      } 
    }
  }

  List res;
  if(useResid){
    res = List::create(    // Rcpp::Named("ssq") = ssq,
			      // Rcpp::Named("sumlog") = sumlog,
			      // Rcpp::Named("nu") = (double) nu,
		       NumericVector::create(ssq, sumlog, (double) nu),
		       rsResid,
		       states,    // 2018-08-23 new
		       gainVec);  // 2018-08-23 new
  }else{
    res = List::create( NumericVector::create(ssq, sumlog, (double) nu)	);    
  }

  if(update[0]){
    res.attr("mod") = List::create( _["phi"] = phi, _["theta"] = theta, _["Delta"] = Delta,
				    _["Z"]   = Z,   _["a"] = a,
				    _["P"]   = P,   _["T"] = T, _["V"] = V, _["h"] = h,
				    _["Pn"]  = Pnew
				   );
      }
  
                 // before 2018-08-23 was only: ssq, sumlog, nu and possibly residuals;
  return res;    // ssq, sumlog, nu, and possibly residuals (ordinary and standardised), state values, and gains,;
}
