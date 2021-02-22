* Figure: Density plots with averages

    * Load data
    * ---------
    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/density-av.dta", clear
    
    * Calculate means
    * ---------------
    sum     revenue if post == 0 // summarize the variable
    local     pre_mean = r(mean) // store returned mean (control)
    sum        revenue if post == 1 
    local     post_mean = r(mean) // repeat for treatment, store returned mean
    
    * Plot
    * ----
    twoway     (kdensity revenue if post == 0, color(gs10)) /// kernel density plot for 
            (kdensity revenue if post == 1, color(emerald)) /// both treatment and control groups
         , ///
            xline(`pre_mean', lcolor(gs12) lpattern(dash)) /// xline using the local variables for the means
            xline(`post_mean', lcolor(eltgreen) lpattern(dash)) /// stored earlier
            legend(order(1 "Pre-treatment" 2 "Post-treatment")) ///
            xtitle(Agriculture revenue (BRL thousands)) /// add graph specs
            ytitle(Density) ///
            bgcolor (white) graphregion(color(white))
            
* Have a lovely day!
