* Figure: Density graph with data points

    global graph_opts title(, justification(left) color(black) span pos(11)) /// graph options global, legend details, line details, etc.
        graphregion(color(white)) ylab(,angle(0) nogrid notick) xscale(noline) yscale(noline) yline(0 , lc(black)) ///
        xtit(,placement(left) justification(left)) legend(region(lc(none) fc(none)))

    global hist_opts ylab(, angle(0) axis(2)) yscale(noline alt axis(2)) ///histogram options
        ytit(, axis(2)) ytit(, axis(1)) yscale(off axis(2)) yscale(alt)

    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/density-data.dta"  , clear

    qui su theta_mle //summarize theta_mle

    gen score = theta_mle - `r(min)' //subtract the returned minimum to set knowledge score
    gen bach = roster_6a8 > 4 //indicator for >4 years of college

    tw ///
        (kdensity score if bach == 0 , lp(dash) lc(maroon) yaxis(2)) ///kernel density for <=4 years
        (kdensity score if bach == 1 , lp(dash) lc(navy) yaxis(2)) /// '' '' '' for > 4 years
        (histogram score if bach == 0 , freq w(.1) recast(scatter) msize(small) mc(maroon)) ///similar stuff, but histogram w/ frequency weights
        (histogram score if bach == 1 , freq w(.1) recast(scatter) msize(small) mc(navy)) ///and recast it as a scatter plot
        , ///
        legend(symxsize(small) ///
               order(0 "" 0 "" 0 "{bf: Degree:}" ///
                     3 "Intermediate, Undergrad, or Bachelors (N=575)" /// show only the scattered histogram symbols in the legend
                     4 "Specialist or Masters (N=431)") ///
               c(1) pos(11) ring(0)) ///
        ${graph_opts} ${hist_opts} /// use the globals set earlier 
        xtit("Knowledge Score {&rarr}") xlab(0(1)7) yline(10 20 30 , lc(gs12) lp(dot)) xsize(7)


* Have a lovely day!
