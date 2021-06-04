/* 	
  Figure: Regression Fit

	Data Source:
	---------------------
	Jishnu Das, Benjamin Daniels, Monisha Ashok, Eun-Young Shim, and Karthik Muralidharan
	Two Indias: The structure of primary health care markets in rural Indian villages with implications for policy.
  doi: https://doi.org/10.1016/j.socscimed.2020.112799
  repo: https://github.com/bbdaniels/ssm-rhcp-2020
  
*/
  
  use "https://github.com/worldbank/stata-visual-library/blob/bbd-graphs/Library/data/regression-fit.dta?raw=true" , clear

	keep uvillid private state_code type_1 type_2 type_3 type_4 smses weight_psu u5mr
	
  reshape wide type_?         ///
    , i(uvillid)  j(private)  // Reduce to village level
		drop type_4?              // Exclude unknown providers

  // Total number of providers per village
	egen nprov = rowtotal(type*)

  // Collapse to state level
	collapse ///
    (firstnm) smses u5mr  ///
    (mean) type* nprov    /// average numbers of providers per village
    [pweight = weight_psu] , by(state_code)

  // Calculate share of non-mbbs private providers
	gen nonmbbs = (type_31 + type_21) / nprov

  // Normalize state-mean SES
	egen norm = std(smses)

  // Calculate regression coefficients
  reg nonmbbs norm
    mat a = r(table)
    local b1 = a[1,1]
    local p1 = a[4,1]
    local r1 = e(r2)
  reg nonmbbs norm if nonmbbs > 0.4 // Exclude Kerala
    mat a = r(table)
    local b2 = a[1,1]
    local p2 = a[4,1]
    local r2 = e(r2)

    foreach param in b1 p1 b2 p2 r1 r2 {
      local `param' : di %3.2f ``param''
    }

  // Graph
	tw                                                                          ///
    (lfitci  nonmbbs norm  , lc(black) lp(dash) acolor(gs14) alp(none) )        ///
    (lpoly   nonmbbs norm  , lw(thick) lc(maroon) )                             ///
		(scatter nonmbbs norm  , m(.) mc(black) mlab(state_code) mlabangle(20) mlabc(black) mlabpos(9) mlabsize(vsmall))    ///
    (scatteri 0.10 -2 "Regression Coefficient: `b1' (p=`p1', R{superscript:2}=`r1')" , m(none) mlabc(black))                ///
    (scatteri 0.05 -2 "Regression Ex. Kerala: `b2' (p=`p2', R{superscript:2}=`r2')" , m(none) mlabc(black))                 ///
	   , title("") note("") legend(off)                                                                                     ///
		ylab($pct) ytit("Share of Private Non-MBBS Providers" , placement(left) justification(left))                        ///
		xlab(-2 "-2 SD" -1 "-1 SD" 0 `""Average" "{&larr} State SES {&rarr}""' 1 "+1 SD" 2 "+2 SD") xtit("")

* Have a lovely day!
