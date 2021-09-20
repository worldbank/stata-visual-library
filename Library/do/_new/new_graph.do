
/* 
  Figure: 

    Data Source:
    ------------------
    cencus from default Stata directory
    
*/

    sysuse census, clear

  * Generate a variable to avoid overlapping
    gen pop18_65 =  pop18p - pop65p                  
  
    local pop_age poplt5 pop5_17 pop18_65 pop65p

    cap mat drop a 
    cap mat drop theResults 

    foreach pop in `pop_age'{
        gen ratio_`pop' = `pop' / pop
 
      preserve
        collapse (min) min_ratio_`pop' = ratio_`pop' ///
                 (max) max_ratio_`pop' = ratio_`pop' ///
               , by(region) 
        mkmat *, matrix(a)
        mat list a
  
        local r1  = a[1,1]
        local ll1 = a[1,2]
        local ul1 = a[1,3]
        local r2  = a[2,1]
        local ll2 = a[2,2]
        local ul2 = a[2,3]

        mat a = [`r1',`ll1',`ul1' \ `r2',`ll2',`ul2']  
        mat rownames a = "`pop'" "`pop'" 
        mat list a
        mat theResults = (nullmat(theResults) \ a)  

      restore
    }
    
    mat colnames theResults = "region" "min" "max"
    mat list theResults 

    clear
    svmat theResults , names(col)
 
    label define region 1 "NE" 2 "N Cntrl" 3 "South" 4 "West" 
    label values  region region
 
    gen n = _n
    replace n = 9 - n
    tw ///
        (rcap min max n if region == 1 , hor lc(gs12))                       ///
        (scatter n min if region == 1 , color(blue))                         ///
        (scatter n max if region == 1 , color(gold) mlabel(region))          ///
        (rcap min max n if region == 2 , hor lc(navy))                       ///
        (scatter n min if region == 2 , color(blue))                         ///
        (scatter n max if region == 2 , color(gold) mlabel(region))          ///
      , ///
        bgcolor(white) graphregion(color(white))                             ///
        ylab( 7.5 "Population (<5yrs)" 5.5 "Population (5-17yrs)"            ///
            3.5 "Populatoion(18-65yrs)" 1.5 "Population (65 yrs<)" ,         ///
            labsize(small) angle(0))                                         ///
        ytit(" ")                                                            ///
        xlab( .2 "20%" .4 "40%"  .6 "60%")                                   ///
        yscale(noline) xscale(range(0 .65)  noline)                          ///
        legend(order(2 3) label(2 "Minimum") label(3 "Maximum")              ///
            region(lc(none) fc(none)))                                       ///
        title("Comparison of ration of age groups",                          ///
            justification(center) color(black) span pos(12))  

