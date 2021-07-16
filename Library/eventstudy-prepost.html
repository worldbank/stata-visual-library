/*
  Figure: Simple event study graph

	Data Source:
	---------------------
	This is a mock data set.
*/

    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/eventstudy-prepost.dta", clear
    
    /// Get time point of reference
    sum t
    local tmax = r(max)
    local tmin = r(min)
    
    sum t if post == 0
    local tevent = r(max)    // This is the base period
    local tpostmin = `tevent'

    /// Calculate post-event average
    reg y post
    
    mat results = r(table)

    local postcons = results[1,1]
    local postll = results[5,1]
    local postul = results[6,1]
    
    /// Calculate effect for each ride
    reg y ib`tevent'.t    // t = 0 is the time of the event

    /// Load the results as the data set so they're easier to handle
    mat pointest = r(table)
    mat pointest = pointest'

    /// Clear, and Load data ready for plotting
    clear
    svmat pointest, names(col)
    local lastobs  = _N
    gen time = _n
    drop in `lastobs'            // this is the constant
    
    twoway                                          ///
    (rspike ul ll time, msize(tiny) color(gs10))  ///
    (scatter b time, msize(tiny) color(gs8))      ///
    (scatteri 0 0 0 `tevent', recast(connected) msymbol(none) lcolor(cranberry)) ///
    (scatteri `postcons' `tevent' `postcons' `tmax', recast(connected) msymbol(none) lcolor(navy)) ///
    (scatteri `postul' `tevent' `postul' `tmax', recast(connected) lpattern(dash) msymbol(none) lcolor(navy)) ///
    (scatteri `postll' `tevent' `postll' `tmax', recast(connected) lpattern(dash) msymbol(none) lcolor(navy)) ///
    , ///
    graphregion(color(white)) ///
    legend(off) ///
    xlabel(none) ///
    xtitle(Time) ///
    ytitle(Outcome variable) ///
    title("Event Study Graph", justification(left) color(black) span pos(17))

* Have a lovely day!

