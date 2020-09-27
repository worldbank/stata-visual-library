* Regression coefficient chart/table

cap prog drop chartable
prog def chartable

syntax varlist [if] [in] [using], Command(string asis) rhs(string asis) [or] [Pstars] [regopts(string asis)] [globalif] [*]

preserve
marksample touse, novarlist
keep if `touse'

qui if "`or'" == "or" { // odds-ratio / logistic regressions: bounded by [1/100 , 100]

	local theVar : word 1 of `rhs'

	cap mat drop theResults

	foreach var of varlist `varlist' {
	
	tempfile allData
	save `allData', replace
		if "`globalif'" != "" keep if 1 $`var'

			local theLabel : var label `var'
			local theLabels =  `"`theLabels' "`theLabel'" "'

			`command' `var' `rhs', `or' `regopts'
			
			mat mattemp = r(table)
			mat nextResults = mattemp[1...,1]
			
				count if `var' == 1
					local y = `r(N)'
				count
					local n = `r(N)'
				sum `var'
					local x = `r(mean)'
					
				count if `var' == 1 & `theVar' == 0
					local y0 = `r(N)'
				count if `theVar' == 0
					local n0 = `r(N)'
				sum `var' if `theVar' == 0
					local x0 = `r(mean)'
					
				count if `var' == 1 & `theVar' == 1
					local y1 = `r(N)'
				count if `theVar' == 1
					local n1 = `r(N)'
				sum `var' if `theVar' == 1
					local x1 = `r(mean)'
					
				mat nextResults = nextResults \ [ `y' , `n' , `x' , `y0' , `n0' , `x0' , `y1' , `n1' , `x1' ]' 

			mat theResults = nullmat(theResults) , nextResults	
	use `allData', clear		
		}
		
		mat theResults = theResults 
		mat theResult = theResults'
			
		clear
		svmat double theResult, n(matcol)
			
		gen b2 = string(round(theResultb,.01))
			if "`pstars'" != "" {
				replace b2 = b2 + "*" if theResultpvalue < 0.1
				replace b2 = b2 + "*" if theResultpvalue < 0.05
				replace b2 = b2 + "*" if theResultpvalue < 0.01
				* local pnote "note:  *** p<0.01, ** p<0.05, * p<0.1"
				}
		
		gen ll2 = string(round(theResultll,.01))
		gen ul2 = string(round(theResultul,.01))
		gen m2 = string(round(theResultr12,.01))
			rename ///
				(theResultr10 theResultr11 theResultr12 theResultr13 theResultr14 theResultr15 theResultr16 theResultr17 theResultr18) ///
				(y N x y0 N0 x0 y1 N1 x1)
			
		gen n = _n
		
		qui count
		
			local n1 = `r(N)' + 1
			local n2 = `r(N)' + 2
		set obs `n2'
			replace n = `n1' in `n1'
			replace n = 0 in `n2'
			replace b2 = "OR" in `n1'
			replace ll2 = "Lower" in `n1'
			replace ul2 = "Upper" in `n1'
			replace m2 = "Mean" in `n1'
			
		gen less 	= .01
		gen b 		= 200
		gen ll 		= 1000
		gen ul 		= 5000
		gen m		= 25000
		gen more 	= 500000
		
		replace n = `n2' - n - 1 if (n != 0 & n != `n1')
		
		gen label = ""
			forvalues i = 1/`r(N)' {
				local pos = `n2' - `i' - 1
				local next : word `i' of `theLabels'
				replace label = "`next'" if n == `pos'
				local labels `"`labels' `pos' "`next'""'
				}
		
		tw 	(rcap theResultll theResultul n, horizontal lc(black)) ///
			(scatter n theResultb , ms(o) mc(black)) ///
			(scatter n b, mlabel(b2) ms(none)  mlabc(black)) ///
			(scatter n ll, mlabel(ll2) ms(none)  mlabc(black)) ///
			(scatter n ul, mlabel(ul2) ms(none) mlabc(black)) ///
			(scatter n m, mlabel(m2) ms(none) mlabc(black)) ///
			(scatter n more,  ms(none)) ///
			(scatter n less,  ms(none)) ///
			, 	xscale(log) xlab(0.01 "0.01" 0.1 "0.1" 1 "1.0" 10 100, notick) ylab(`labels', angle(0) nogrid notick) ///
				xline(0.01, lc(black)) xline(1, lc(gray) lp(dash)) xline(10, lc(gray) lp(dot)) xline(0.1, lc(gray) lp(dot)) xline(100, lc(black)) ///
				yscale(noline) xscale(noline) ytit("") legend(off) graphregion(color(white)) xsize(7) caption(`"`pnote'"', pos(7) span size(small)) `options'
		
		if `"`using'"' != `""' {
			keep theResult* label y N x y0 N0 x0 y1 N1 x1
			rename theResult* *
			
			label var label "Variable"
			label var y "Number of Successes"
			label var N "Number of Observations"
			label var x "Proportion Successes"
			label var y0 "Number of Successes if `theVar' = 0"
			label var N0 "Number of Observations if `theVar' = 0"
			label var x0 "Proportion Successes if `theVar' = 0"
			label var y1 "Number of Successes if `theVar' = 1"
			label var N1 "Number of Observations if `theVar' = 1"
			label var x1 "Proportion Successes if `theVar' = 1"
			label var b "OR Point Estimate"
			label var se "Standard Error"
			label var z "Z Statistic"
			label var p "P Value"
			label var ll "Lower 95% CI"
			label var ul "Uper 95% CI"
			
			export excel label y N x y0 N0 x0 y1 N1 x1 b se z pvalue ll ul `using' , replace first(varl)
			}
			
	} // end logistic regressions (OR option)

end
