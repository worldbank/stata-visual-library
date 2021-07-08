/*
  Figure: scatter plot with fitted line

	Data Source:
	--------------------------
	Use built-in data: auto
*/

  sysuse auto, clear

  /// graph options
  local col_domestic 	midblue
  local col_foreign  	red
  local transparency  %30
  local point_width	  0
  local point_size		small

  twoway  ///
    (scatter price mpg if foreign == 0, mfcolor(`col_domestic'`transparency') msize(`point_size') mlwidth(`point_width')) ///
    (lfit price mpg if foreign == 0, color(`col_domestic')) ///
    (scatter price mpg if foreign == 1, mfcolor(`col_foreign'`transparency') msize(`point_size')  mlwidth(`point_width')) ///
    (lfit price mpg if foreign == 1, color(`col_foreign'))  ///
    , ///
    graphregion(color(white)) ///
    legend(order(2 "Domestic" 4 "Foreign")) ///
    title("Scatter plot with fitted line", justification(center) color(black) span pos(17))
