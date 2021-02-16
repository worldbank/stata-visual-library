*Make a scatter plot with confidence interval
 
 use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/scatter-fl-ci.dta"

  * Graph
    twoway ///
        (lfitci gdp_per_cap_growth morality_rate) ///
        (scatter gdp_per_cap_growth morality_rate if continent == "Europe & Central Asia", mcolor(cranberry) m(O) )  ///
        (scatter gdp_per_cap_growth morality_rate if continent == "South Asia",   mcolor(dkgreen) m(D) ) ///
        (scatter gdp_per_cap_growth morality_rate if continent == "Middle East & North Africa", mcolor(ebblue ) m(T) ) ///
        (scatter gdp_per_cap_growth morality_rate if continent == "East Asia & Pacific", mcolor(dkorange) m(O)) ///
        (scatter gdp_per_cap_growth morality_rate if continent == "Sub-Saharan Africa", mcolor(navy) m(D) ) ///
        (scatter gdp_per_cap_growth morality_rate if continent == "Latin America & Caribbean", mcolor(red) m(T)) ///
		(scatter gdp_per_cap_growth morality_rate if continent == "North Amercia", mcolor(yellow) m(D)) ///
      ,  ///
        xlabel(0(20)120)         ///
        xtitle("Morality Rate under 5 (Per 1,000 lives) ", axis(1)) ///
        ylabel(-10(5)25) ///
        ytitle("Annual GDP per Capita Growth Rate (%)" ) ///
        legend(order( 3 4 5 6 7 8 9) label(3 "East Asia & Pacific") label(4 "Europe & Central Asia") ///
		label(5 "Latin America & Caribbean")  label(6 "Middle East & North Africa") label(7 "North America")  ///
        label(8 "South America")  label(9 "Sub-Saharan Africa")   ///
        ring(0) position(1)) ///
        title("Morality Rate under 5 and GDP per Capita Growth " "Correlation")  ///
        note("Source: World Development Indicatior (2019)") /// 
        graphregion(color(white)) bgcolor(white) 

* Have a lovely day!
