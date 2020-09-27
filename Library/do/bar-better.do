* Figure: Horizontal bar with multiple variables

    global  graph_opts ///
            title(, justification(left) ///
            color(black) span pos(11)) ///
            graphregion(color(white)) ///
            ylab(,angle(0) nogrid) ///
            xtit(,placement(left) justification(left)) ///
            yscale(noline) xscale(noline) ///
            legend(region(lc(none) fc(none)))
			
    global  pct `" 0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%" "'
    
    qui do "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/ado/betterbar.ado"	

    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/bar-better.dta" , clear

    betterbar ///
        ??_correct  checklist  refer med_any  med_class_any_6 med_class_any_16 ///
        , ///
        ${graph_opts} ///
        over(facility_type) ///
        xlab(${pct}) ///
        barlab(mean) ///
        legend(r(1) symxsize(small) symysize(small))
				
* Have a lovely day!
