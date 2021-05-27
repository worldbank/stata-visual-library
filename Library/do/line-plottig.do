* Figure: Line graph with plottig scheme

/* 
	Data Source:
	------------------
	sp500 from default Stata directory
	
	Install Scheme (if needed)
	-----------------------------
	We need one scheme to run this file: blindschemes
	Please remove "*" from below lines if you have not installed them and would like to install.
*/

    * ssc install blindschemes, replace
	
    /// Select graph scheme (similar to R's ggplot2)
    set scheme plottig

    /// Load built-in data
    sysuse sp500, clear
	
    /// Create graph: show time series for 4 variables
    twoway  (line high date) ///
			(line low date) ///
			(line close date) ///
			(line open date) , ///
			title("Line graph with plottig scheme",justification(left) color(black) span pos(11))

******************************* End of do-file *********************************
