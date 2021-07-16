
/* 
  Figure: 

    Data Source:
    ------------------
    cencus from default Stata directory
    

    Install Packages (if needed)
    ----------------------------
    We need one package to run this file: grc1leg
    Please remove "*" from below lines if you have not installed it and would like to install.

    * net install st0357.pkg
*/




* Simple type
    sysuse census, clear

    preserve
        collapse (min) min_pop = pop   (max) max_pop = pop  (mean) mean_pop = pop  ///
          , ///
            by(region)
                               
        twoway ///
            (pcspike  region min_pop region max_pop , color(gs12)) ///
            (scatter region min_pop, color(blue))                ///
            (scatter region max_pop, color(gold))                ///
            (scatter region mean_pop, color(green) m(D) msize(*0.7))                ///
          , ///
            xlabel(, labsize(vsmall) valuelabel)                                            ///
            xtitle("Population of the state")                                              ///
            ylabel( ,  labsize(vsmall)  valuelabel angle(horizontal))                          ///
            ytitle("Region",)                    ///
            legend(order(2 3 4)  label (2 "Minimum population size") label(3 "Max Population size") ///
                label(4 "Average Population size of state"))     ///                                         ///
            title("Population distribution by region in the US")                                              ////
            note()
    restore



*  Combine Graphs
    sysuse census, clear

    gen urban_percent = popurban/pop
    gen pop_u18_percent = (poplt5 + pop5_17)/pop
    gen pop65_percent = pop65p/pop
    gen mortality = death/(pop/100000) 

    label var urban_percent        ///
        "Proportion of urban population"
    label var pop_u18_percent      ///
        "Proportion of the population under 18"
    label var pop65_percent        ///
        "Proportion of the population over 65"
    label var mortality            ///
        "Mortality rate (death / 100,000) "


    local targetvar urban_percent pop65_percent pop_u18_percent mortality
    

    foreach varname of var `targetvar' {
      * Copy variable labels before collapse
        local l`varname' : variable label `varname'
 
      preserve
        collapse (min) min_`varname' = `varname'   (max) max_`varname' = `varname' ///
                 (mean) mean_`varname' = `varname'                                 ///
                , ///
                 by(region)
        
        drop if region == 3 | region == 4 

        twoway ///
            (pcspike region min_`varname' region max_`varname' , color(gs12))     ///
            (scatter region min_`varname' , color(blue))                          ///
            (scatter region max_`varname' , color(gold))                          ///
            (scatter region mean_`varname', color(green) m(D) msize(*0.7))       ///
          , ///
            xlabel(, labsize(vsmall))                                  ///
            xtitle("`l`varname''")                                                      ///
            ylabel( ,  labsize(vsmall)  valuelabel angle(horizontal))                        ///
            ytitle("Region",)                                               ///
            legend(order(2 3 4)  label (2 "Minimum") label(3 "Maximum") ///
                label(4 "Average"))                                          ///                                    
            title("`l`varname'' by region")                                              ////
            note()                                               ///
            name(`varname', replace)
      restore
    }

    * Combine graphs
    grc1leg `targetvar', altshrink legendfrom(urban_percent)
