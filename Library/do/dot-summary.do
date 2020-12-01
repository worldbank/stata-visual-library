* Reproduced from: 
*   Two Indias: The structure of primary health care markets 
*   in rural Indian villages with implications for policy
* By Jishnu Das, Benjamin Daniels, Monisha Ashok, Eun-Young Shim, and Karthik Muralidharan
* https://doi.org/10.1016/j.socscimed.2020.112799
* https://github.com/bbdaniels/ssm-rhcp-2020

use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/confidence-intervals.dta" , clear

  egen total = rsum(type_?)
  gen any = (total>0)

  collapse (max) any regsim_? (mean) weight_psu , by(state_code villid) fast
  collapse (mean) any (mean) regsim_? , by(state_code)

  forvalues i = 1/3 {
    replace regsim_`i' = regsim_`i'*any
  }

  egen check = rank(regsim_3) , unique
    sort check
  decode state_code , gen(state)

  qui count
  forvalues i = 1/`r(N)' {
    local theState = state[`i']
    local theRank = check[`i']
    local theLabels = `"`theLabels' `theRank' "`theState'" "'
  }

  graph dot any regsim_1 regsim_2 regsim_3 ///
  , over(state, sort(4) descending axis(noline) label(labsize(small))) ///
      marker(1, m(T) msize(*3) mlc(white) mlw(vthin) mla(center)) ///
      marker(2, m(O) msize(*3) mlc(white) mlw(vthin) mla(center)) ///
      marker(3, m(S) msize(*3) mlc(white) mlw(vthin) mla(center)) ///
      marker(4, m(D) msize(*3) mlc(white) mlw(vthin) mla(center)) ///
    linetype(line) line(lw(thin) lc(gs14)) ///
    legend(on span c(1) size(small) order( ///
        1 "Villages with any providers" ///
        2 "Villages with MBBS providers" ///
        3 "Villages with providers better than state average MBBS" ///
        4 "Villages with providers better than national average MBBS")) ///
    ylab(${pct}) ytit("Proportion of villages {&rarr}") yscale(r(0) noline) ///
    legend(region(lc(none) fc(none))) noextendline ysize(6) ///
    ytit(,placement(left) justification(left))
    
* Have a lovely day!
