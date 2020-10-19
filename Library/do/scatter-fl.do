*Figure: scatter plot with fitted line

    * Load data
    * ---------
    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/scatter-fl.dta", clear
    
    * Plot
    * ----
	
	/*You can do this combination of different types of graphs for any type in the twoway family in
	this fashion; for more, read the help files provided by Stata*/
	
    twoway  (scatter revenue area_cult if post == 0, msize(vsmall) mcolor(gs14)) /// scatter the data
            (lfit revenue area_cult if post == 0, color(gs12)) ///  fit the line
            (scatter revenue area_cult if post == 1, msize(vsmall) mcolor(stone)) ///scatter more data
            (lfit revenue area_cult if post == 1, color(sand)) /// fit another line
         , ///
            ytitle(Agriculture revenue (BRL thousands)) /// Y-label
            xtitle(Cultivated area) /// X-label
            legend(order(2 "Pre-treatment" 4 "Post-treatment")) /// legend
            bgcolor (white) graphregion(color(white)) //more customization of background and graph color
            
* Have a lovely day!
            
