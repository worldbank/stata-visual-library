* Reproduced from: 
*   Two Indias: The structure of primary health care markets 
*   in rural Indian villages with implications for policy
* By Jishnu Das, Benjamin Daniels, Monisha Ashok, Eun-Young Shim, and Karthik Muralidharan
* https://doi.org/10.1016/j.socscimed.2020.112799
* https://github.com/bbdaniels/ssm-rhcp-2020

use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/confidence-intervals.dta" , clear

  // Get graphing points
  gen count = 1
  collapse (sum) count (mean) mean = theta_mle (sem) sem = theta_mle , by(mbbs statename)
    gen ul = mean + 1.96*sem
    gen ll = mean - 1.96*sem

  // Set up labelling and ordering
  bys statename : egen check = max(mean)
    sort check mbbs
    gen n = _n

    local x = 0
    local y = 0
    forv i = 1/`c(N)' {
      replace n = n + `x' in `i'
      local ++y
      if `y' == 2 {
        local x = `x' + 4
        local y = 0
      }
    }

    gen pos = -4.5
    gen pos2 = n

  // Graph
	tw ///
    (rcap ll ul n , lw(thin) lc(black) hor) ///
    (scatter n mean if mbbs == 0, mc(white) mlc(black) mlw(thin) m(s) msize(med)) ///
    (scatter n mean if mbbs == 1, mc(black) m(.) mlw(none) msize(medsmall)) ///
    (scatter pos2 pos if mbbs == 1, mlabpos(3) m(none) ml(statename) mlabc(black)) ///
  , yscale(off) xlab(-3(1)2, labsize(small)) ysize(6) ///
    legend(on size(small) order (2 "Non-MBBS" 3 "MBBS") ring(0) pos(5) c(1)) ///
    xtit("{&larr} Average Provider Competence {&rarr}")

* Have a lovely day!
