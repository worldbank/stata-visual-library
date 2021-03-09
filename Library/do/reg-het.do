* Figure: Marginal effects by heterogeneity gorups
			
/* 
	Data Source:
	--------------------------
	Use built-in data: auto
*/
			
	sysuse auto, clear

	/// prepare option
	local label1 Foreign
	local label0 Domestic
	
	/// Supress y axis labels on graph to the right so it's only shown once on 
	/// combined graph
	local yopts1 ylab(, labcolor(white)) /// 
				 ytitle("") ///
				 yscale(noline)
				 
	gr drop _all
		
	/// create individual graph
	/// Loop over heterogeneity variables
	forvalues foreign = 0/1 {
		reg price mpg headroom if foreign == `foreign'	 		/// Run regression to get margin effect		

		/// Plot marginal effect by group
		coefplot ///
			   , ///
			    drop(_cons) /// don't show constant 
				vertical ///
				yline(0, lpattern(dash)) /// for significance
				ciopt(color(gs10 gs10) ///
					  recast(rcap)) ///
				levels(90 95) /// show 90% and 95% CIs
				ylab(, noticks glcolor(gs15)) ///
				xlab(, noticks labsize(small)) ///
				xtitle("") ///
				ytitle("Marginal effect on price") ///
				title(`label`foreign'', box bexpand bcolor(gs15)) /// add title in box
				color(black) ///
				name(f`foreign') ///
				graphregion(color(white)) ///
				`yopts`foreign''

		
	}
	/// Combine graph				
	gr combine 	f0 f1, ///
				ycommon ///
				graphregion(color(white))
	
* Have a lovely day!
