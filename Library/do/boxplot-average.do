* Figure: 10-25-50-75-90 Percentile box plot with averages
		
	* Load data	
	use	  "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/boxplot-averages.dta"	, clear
	
	* Drop missing values 
	drop if yield == . 
	
	* Generate average, median, and percentiles
	egen 	average =   mean(yield) 		  	  , by(crop)
	format  average   %9.3f
	egen 	median  = median(yield) 		  	  , by(crop)
		
	foreach    percentile in 10 25 75 90 		  {
	
		egen p`percentile' = pctile(yield)  	  , by(crop) p(`percentile')   
	}
	
	* Set order of bars
	recode crop (1 = 1) (10 = 2) (24 = 3) (25 = 4), gen(order)
	
	* Set graph options
	local fillOptions "fcolor(eltblue) fintensity(inten50)"
	local lineOptions "lcolor(eltblue) lwidth(0.275)"
	
	* Plot by crop
	#d	;
		
		// Boxes
		tw (rbar   median p25 order, horiz `fillOptions' `lineOptions' barw(0.5) )	
		   (rbar   median p75 order, horiz `fillOptions' `lineOptions' barw(0.5) )
		
		// Whiskers
		   (rspike 	  p10 p25 order, horiz 				 `lineOptions' 			 )
		   (rspike 	  p75 p90 order, horiz 				 `lineOptions'		 	 )
		   
		   (rcap   	  p10 p10 order, horiz 				 `lineOptions' msize(*4) )
		   (rcap   	  p90 p90 order, horiz 				 `lineOptions' msize(*4) )
		
		// Average dots
		   (dot       average order, horiz ndot(0)
									 msymbol(cirlce) msize(medlarge)
									 mcolor(midblue)
									 mlab(average) mlabpos(12) mlabgap(5) 
									 mlabcolor(black*0.8) mlabsize(medsmall)     )
				,
				
				xlab(0(0.5)2)
				ylab(1 "Maize"
					 2 "Pigeon pea"
					 3 "Sesame"
					 4 "Soy"
					 ,  noticks angle(h) labgap(*3.5)
					 )
				
				legend(order(1 "Q{sub:25}-Q{sub:75}" 
							 5 "Q{sub:10}-Q{sub:90}"
							 7 "Average")
					   rows(1)
					   )
				
				xtitle("Yield (in Ton/Ha)") xscale(titlegap(2))
				ytitle("")
				graphregion(color(white))
		;
	#d	cr
	
	gr export "boxplot-averages.png", width(5000) replace
		
* End of the do-file
