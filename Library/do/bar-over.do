* Figures: bar plot of two variables

    global graph_opts1 ///
           bgcolor(white) ///
           graphregion(color(white)) ///
           legend(region(lc(none) fc(none))) ///
           ylab(,angle(0) nogrid) ///
           title(, justification(left) color(black) span pos(11)) ///
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
          ylab(${pct})

* Have a lovely day!
