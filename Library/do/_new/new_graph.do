
/* 
  Figure: 

    Data Source:
    ------------------
    cencus from default Stata directory
    
*/



* Simple type
    sysuse census, clear

    preserve
        collapse (min) min_pop = pop   (max) max_pop = pop  (mean) mean_pop = pop  ///
          , ///
            by(region)
                               
        twoway ///
            (pcspike  min_pop region max_pop region, color(gs12)) ///
            (scatter min_pop region , color(blue))                ///
            (scatter max_pop region , color(gold))                ///
            (scatter mean_pop region , color(green) m(D) msize(*0.7))                ///
          , ///
            xlabel(, labsize(vsmall) valuelabel)                                            ///
            xtitle("Region")                                              ///
            ylabel( ,  labsize(vsmall)  angle(horizontal))                          ///
            ytitle("Population of the state",)                    ///
            legend(order(2 3 4)  label (2 "Minimum population size") label(3 "Max Population size") ///
                label(4 "Average Population size of state"))     ///                                         ///
            title("Population distribution by region")                                              ////
            note()
    restore




*  Combine Graphs
    sysuse census, clear

    local targetvar pop medage
    

    foreach varname of var `targetvar' {
      * Copy variable labels before collapse
        local l`varname' : variable label `varname'
 
      preserve
        collapse (min) min_`varname' = `varname'   (max) max_`varname' = `varname' ///
                 (mean) mean_`varname' = `varname'                                 ///
                , ///
                 by(region)
                               
        twoway ///
            (pcspike  min_`varname' region max_`varname' region, color(gs12))     ///
            (scatter min_`varname' region , color(blue))                          ///
            (scatter max_`varname' region , color(gold))                          ///
            (scatter mean_`varname' region , color(green) m(D) msize(*0.7))       ///
          , ///
            xlabel(, labsize(vsmall) valuelabel)                                  ///
            xtitle("Region")                                                      ///
            ylabel( ,  labsize(vsmall)  angle(horizontal))                        ///
            ytitle("`l`varname''",)                                               ///
            legend(order(2 3 4)  label (2 "Min `l`varname''") label(3 "Max `l`varname''") ///
                label(4 "Average `l`varname''"))                                          ///                                    
            title("`l`varname'' by region")                                              ////
            note()                                               ///
            name(`varname', replace)
      restore
    }

    gr combine `targetvar', col(1) altshrink
