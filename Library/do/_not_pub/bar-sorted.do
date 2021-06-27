/*  
  Figure: Sorted bar graph

	Data Source:
	---------------------
  
  lifeexp from Stata
*/
	
	 global graph_opts1 ///       //global set so options can be accessed by other do-files
          graphregion(color(white) lc(white) la(center)) /// <- remove la(center) for Stata < 15
           
	
	*load data
	
	sysuse lifeexp, clear
	
	qui su lexp, de //calculate summary statistics to get 75th percentile
	
	/* Graph horizontal bars that are sorted in descending order; population growth
	by country with >75th percentile life expectancy */

  graph hbar popgrowth if lexp > `r(p75)',  ///
    over(country, sort(1) descending)       /// sort the bars by shrinking height
    ${graph_opts1}                          ///
    ytitle("Average Annual Percent Growth in Population") ///
    scale(*.75) bar(1, lc(black) lw(thin) fc(emerald)) //scale resizes text and lines so it's not as crowded

*Have a lovely day!*
