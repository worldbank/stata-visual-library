* 	Figures: bar plot of two variables

/* 
	Data Source:
	---------------------
	Data Replicated from:

	Das, Jishnu, Liana Woskie, Ruma Rajbhandari, Kamran Abbasi, and Ashish Jha.
	“Rethinking assumptions about delivery of healthcare: implications for universal health coverage.” Bmj 361 (2018).
*/

    global graph_opts1 ///
           bgcolor(white) ///
           graphregion(color(white)) ///
           legend(region(lc(none) fc(none))) ///
           ylab(,angle(0) nogrid) ///
           title(, justification(center) color(black) span pos(17)) ///
           subtitle(, justification(left) color(black))

    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-over.dta" , clear

    graph bar treat_correct ///
        , ///
          over(type) ///
          asy ///
          bargap(20) ///
          over(study) ///
          over(case) ///
          nofill ///
          blabel(bar, format(%9.2f)) ///
          ${graph_opts1} ///
          bar(1 , lc(black) lw(thin) fi(100)) ///
          bar(2 , lc(black) lw(thin) fi(100)) ///
          legend(r(1) ///
          order(0 "Measurement:" 1 "Standardized Patient" 2 "Clinical Vignette")) ///
          ytit("Providers ordering correct treatment {&rarr}", ///
               placement(bottom) ///
               justification(left)) ///
          ylab(${pct}) ///
		  title("Bar Plot of Two Variables")

* Have a lovely day!
