* Figure: Horizontal bar with multiple variables
			
    global  pct `" 0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%" "'
    
    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-better.dta" , clear

    betterbar ///
        ??_correct  checklist  refer med_any  med_class_any_6 med_class_any_16 ///
    , over(facility_type) ///
        barlab scale(0.8) ///
        xlab(${pct}) pct ///
        legend(on r(1) symxsize(small) symysize(small))
				
* Have a lovely day!
