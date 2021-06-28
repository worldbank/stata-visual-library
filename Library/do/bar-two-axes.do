/* 
  Figure: combined bar plots with two axex
  
	Data Source:
	---------------------
  Mock data and code were based in 
	Christian, Paul, and Brian Dillon. 2018. “Growing and Learning When Consumption Is Seasonal:
	Long-Term Evidence From Tanzania.” Demography 55 (3): 1091–1118. doi:10.1007/s13524-018-0669-4.
*/

    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-two-axes.dta", clear
    
    gen x = int1mo+.5 /// Adjust variable for bar position
    
    foreach foodGroup in animal fruit grain veg starch processed_sugar {
        /// Create invidual graphs using a loop
        if "`foodGroup'" == "animal"            local graphTitle Animal Sourced
        if "`foodGroup'" == "fruit"             local graphTitle Fruit
        if "`foodGroup'" == "grain"             local graphTitle Grain
        if "`foodGroup'" == "veg"               local graphTitle Vegetables
        if "`foodGroup'" == "starch"            local graphTitle Starchy Foods
        if "`foodGroup'" == "processed_sugar"   local graphTitle ///
            Processed/Sugar

        twoway  bar number_group x if food_group=="`foodGroup'", ///
        yaxis(1) ytitle("Avg. Number of Foods from" "Group Consumed Last Month", axis(1)) ///
        barwidth(.9) fintensity(inten0) lcolor(black) /// 
        xlabel(0 "0" 3 "3" 6 "6" 9 "9" 12 "12") ///
        ylabel(0 "0" 1 "1" 2 "2" 3 "3", axis(1)) || ///
        line total_exp int1mo if food_group=="`foodGroup'", ///
        yaxis(2) ytitle("Total Value of Exp." "1000 Real Tz Sh.", axis(2)) ///
        ylabel(0 "0" 500 "500" 1000 "1000" 1500 "1500" 2000 "2000" 2500 "2500", axis(2)) ///
        xlabel(3 "3" 6 "6" 9 "9" 12 "12") lwidth(1.2) ///
        title("`graphTitle'") xtitle("Month of Interview") ///
        graphregion(color(white)) bgcolor(white) ///
        legend(off) ///
        name("`foodGroup'") 
    }

    graph combine    starch animal fruit grain processed_sugar veg, ///
          title("Combined Bar Plot with Dual Axes", justification(center) color(black) span pos(17)) ///
                graphregion( color(white)) plotregion(color(white)) 
                    
* Have a lovely day!

