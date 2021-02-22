* Figures: bar plot of two variables

	// Set global variable for graph options
    global graph_opts1 ///
           bgcolor(white) ///
           graphregion(color(white)) ///
           legend(region(lc(none) fc(none))) ///
           ylab(,angle(0) nogrid) ///
           title(, justification(left) color(black) span pos(11)) ///
           subtitle(, justification(left) color(black))

global  pct `" 0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%" "'
    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/bar-over.dta" , clear
	
	//create a bar graph w/ y-var treat_correct (% ordering correct treatment)
    graph bar treat_correct ///
        , ///
          over(type) /// group by type of patient
          asy ///  will color by patient grouping
          bargap(20) /// set width of gap between bars
          over(study) /// group by study
          over(case) /// group by case
          nofill ///omitt missing categories
          blabel(bar, format(%9.2f)) ///label the top of the bar = y value with two decimal cases
          ${graph_opts1} /// use pre-specified graph options
          bar(1 , lc(black) lw(thin) fi(100)) ///  set line color, line width, and fill intensity for first "over" group
          bar(2 , lc(black) lw(thin) fi(100)) ///   set line color, line width, and fill intensity for second"over" group
          legend(r(1) ///
          order(0 "Measurement:" 1 "Standardized Patient" 2 "Clinical Vignette")) /// define labels (category 0 is not defined in the data, so only text will be displayed)
          ytit("Providers ordering correct treatment {&rarr}", ///
               placement(bottom) ///
               justification(left)) ///
          ylab(${pct})  // global for horizontal axis label (set earlier in the do-file)

* Have a lovely day!
