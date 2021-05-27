*	Figure: Shaded k-density functions

/* 	
	Data Source:
	---------------------
	Data Replicated file from:
	
		
	Install Packages (if needed)
	-----------------------------
	We need one packages to run this file:  akdensity
	Please remove "*" from below lines if you have not installed them and would like to install.
	
*/ 
   *  ssc install akdensity

    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/density-shaded.dta", replace
	
    sort 	beta_
    gen 	rank 	= _n 
    egen 	p98		= pctile(beta_), p(98) 

    sum 	beta_, det
    local 	mean 	= round(`r(mean)', .00001)
    local 	median 	= round(`r(p50)', .00001)

    /// Graph: DISTRIBUTION OF 2SLS COEFFICIENT ESTIMATES USING RANDOMIZED FOOD AID ALLOCATIONS
    akdensity0 beta_, gen(x) at(beta_) bwidth(.0005) //akdensity0 comes from the user-written package "akdensity"
    
    sum beta_, d
    twoway  area x beta_ if rank>15 & beta_<(`r(p10)'), color(gs14) || /// light shading below 10%
            area x beta_ if beta_>`r(p90)' & rank<980, color(gs14) || ///  light shading above 90%
            area x beta_ if rank>15 & beta_<(`r(p5)'), color(gs9) || ///   dark shading below 5%
            area x beta_ if beta_>`r(p95)' & rank<980, color(gs9) || ///   dark shading above 95%
            line x beta_ if rank>15  & rank<980, lcolor(black) || ///      kernal density plot 
            (pcarrowi -20 .00299 310 .00299, lcolor(cranberry) lpattern(dash) msize(zero)) || ///   overlaying vertical line where the N&Q coefficient is
            (pcarrowi -20 `r(mean)' 310 `r(mean)', lcolor(gs7) lpattern(dash) msize(zero)) || ///   overlaying vertical line where the BS mean is
            (pcarrowi -20 `r(p50)' 310 `r(p50)', lcolor(gs7) lpattern(dash) msize(zero)), ///       overlaying vertical line where the BS median is
            legend(off) ///
            xtitle("2SLS Coefficient from baseline model" " ") ///
            ytitle("Density" " ") ///
            xmlabel(`r(p50)' "Median=`median'" `r(mean)' "Mean=`mean'" , angle(45)) ///
            ylabel(none) ///
            bgcolor(white) graphregion(color(white)) ///
			title("Shaded k-density functions", justification(left) color(black) span pos(17))

* Have a lovely day!
