*	Figure: Scatter plot with transparent points
					
/* 
	Data Source:
	--------------------------
	Use built-in data: auto
*/

	sysuse auto, clear
		
	scatter price mpg ///
		, ///
		mcolor(midblue%50) /// the value after % sets the transparency
		mlwidth(0) /// 		set width of border to 0
		graphregion(color(white)) ///
		title("Scatter plot with transparent points", justification(center) color(black) span pos(17))

* Have a lovely day!
