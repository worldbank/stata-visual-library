*	Figure: Density plot with mean maker

/*
	Data Source:
	---------------------
	This is a mock dataset.
*/


    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/density-av.dta", clear
    

    sum     revenue if post == 0 
    local   pre_mean = r(mean) 
    sum     revenue if post == 1
    local   post_mean = r(mean)

    twoway  (kdensity revenue if post == 0, color(gs10)) ///
            (kdensity revenue if post == 1, color(emerald)) ///
			, ///
            xline(`pre_mean', lcolor(gs12) lpattern(dash)) ///
            xline(`post_mean', lcolor(eltgreen) lpattern(dash)) ///
            legend(order(1 "Pre-treatment" 2 "Post-treatment")) ///
            xtitle(Agriculture revenue (BRL thousands)) ///
            ytitle(Density) ///
            bgcolor (white) graphregion(color(white)) ///
			title("Density Plot with Mean Maker", justification(center) color(black) span pos(17))
            
* Have a lovely day!
