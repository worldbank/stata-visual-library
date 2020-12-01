* Reproduced from: 
*   Two Indias: The structure of primary health care markets 
*   in rural Indian villages with implications for policy
* By Jishnu Das, Benjamin Daniels, Monisha Ashok, Eun-Young Shim, and Karthik Muralidharan
* https://doi.org/10.1016/j.socscimed.2020.112799
* https://github.com/bbdaniels/ssm-rhcp-2020

use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-counts.dta" , clear

  // Create all-India category
  expand 2 , gen(false)
    replace state_code = 0 if false == 1
    lab def state_code 0 "All India" , modify
    replace u5mr = 100 if state_code == 0

  // Add U5MR to titles
  qui levelsof state_code , local(levels)
  foreach state in `levels' {
    local theLabel : label (state_code) `state'
    qui su u5mr if state_code == `state'
    if `state' != 0 lab def state_code `state' "`theLabel' [`r(mean)']" , modify
  }

  // Graph
  local opts  lc(black) lp(solid) lw(vthin) la(center) fc("0 109 219")
  local opts2 lc(black) lp(solid) lw(vthin) la(center) fc("146 0 0")

  graph bar (mean) type_?0 type_?1  [pweight = weight_psu]  ///
  , over(private, gap(*.5) label(labsize(tiny))) ///
    over(state_code , gap(*.5) label(labsize(vsmall)) sort((mean) u5mr) ) ///
    stack hor yscale(noline) ///
    $graph_opts_1 ysize(6) xoverhang ///
    ytit("Providers per Village {&rarr}" , placement(left) justification(left))  ///
    legend(on span region(lc(none)) ring(1) pos(7) r(2) size(small) symysize(small) symxsize(small) ///
     order(13 "Public:"  1 "MBBS" 2 "AYUSH" 3 "Other" 4 "Unknown"  ///
           13 "Private:" 5 "MBBS" 6 "AYUSH" 7 "Other" 8 "Unknown") ///
    ) ///
    bar(1, fi(100) `opts') bar(2, fi(75) `opts') ///
    bar(3, fi(50) `opts') bar(4, fi(25) `opts') ///
    bar(5, fi(100) `opts2') bar(6, fi(75) `opts2') ///
    bar(7, fi(50) `opts2') bar(8,  fi(25) `opts2')
    
* Have a lovely day!
