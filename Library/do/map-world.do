/* 
  Figure: Map

	Data Source:
	--------------------------
	Below codes are replicated from 
	
	Joao Pedro Azevedo, 2011. "WBOPENDATA: Stata module to access World Bank databases," 
	Statistical Software Components S457234, Boston College Department of Economics, revised 09 Jul 2020.

	The author Joao Pedro Azevedo also made available more examples using wbopendata available at  https://github.com/jpazvd/wbopendata

	Install Packages (if needed):
	----------------------------
	We need one package to run this file: wbopendata
	Please remove "*" from below lines if you have not installed them and would like to install.

*/
	* ssc install wbopendata, replace

	/// create a tempfile to store data mined from WDI using wbopendata
	qui tempfile WDIdata 
	wbopendata, language(en - English) indicator(it.cel.sets.p2) long clear latest
	local labelvar "`r(varlabel1)'"
	sort countrycode
	save `WDIdata', replace

	/// create another tempfile from the  world-c.dta which include X and Y coordinate of the country
	qui tempfile worldc 
	qui sysuse world-c.dta, clear
	save `worldc'.dta, replace

	/// merge with world-d.dta which include areas of the country
	qui sysuse world-d.dta, clear
	qui merge countrycode using `WDIdata'
	qui sum year
	local avg = string(`r(mean)',"%16.1f")

	///map out
	spmap it_cel_sets_p2 using `worldc' ///
	, id(_ID) clnumber(20) fcolor(Reds2) ocolor(none ..) ///
	title("`labelvar'", size(*1.2)) legstyle(3) legend(ring(1) position(3)) ///
	note("Source: World Development Indicator")

* Have a lovely day!
