* Figure: Horizontal bar with multiple variables

//Set a global with all graph options and global for horizontal axis labels
    global  graph_opts ///
            title(, justification(left) ///
            color(black) span pos(11)) ///
            graphregion(color(white)) ///
            ylab(,angle(0) nogrid) ///
            xtit(,placement(left) justification(left)) ///
            yscale(noline) xscale(noline) ///
            legend(region(lc(none) fc(none)))
			
    global  pct `" 0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%" "'
	
	*utilizes betterbar.ado, which can be in the ado folder (along w/ documentation)
    
    qui do "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/ado/betterbar.ado"	

    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/bar-better.dta" , clear

    betterbar /// 
        ??_correct  checklist  refer med_any  med_class_any_6 med_class_any_16 /// varlist
        , ///
        ${graph_opts} /// graph options global
        over(facility_type) /// bottom level grouping by facility_type 
        xlab(${pct}) /// horizontal axis label
        barlab(mean) /// bar label option (label is the mean)
        legend(r(1) symxsize(small) symysize(small))
				
* Have a lovely day!
