/*
  Figure: Regression Coefficient plot

	Data Source:
	--------------------------
	Data replicated from:

 	Das, Jishnu, Liana Woskie, Ruma Rajbhandari, Kamran Abbasi, and Ashish Jha.
 	“Rethinking assumptions about delivery of healthcare: implications for universal health coverage.” Bmj 361 (2018).
	
	
	Install Packages (if needed)
	----------------------------
	We need three packages to run this file: firthlogit, st0085_2 (estadd) , dm0037 (xml_tab)
 	Please remove "*" from below lines if you have not installed it and would like to install.
*/

    * ssc inst firthlogit
    * net from http://www.stata-journal.com/software/sj14-2
    * net install st0085_2
    * net from  http://www.stata-journal.com/software/sj8-3
    * net install dm0037 

  run "https://raw.githubusercontent.com/worldbank/stata-visual-library/master/Library/ado/freeshape.ado"
  run "https://raw.githubusercontent.com/worldbank/stata-visual-library/master/Library/ado/labelcollapse.ado"

  * Load data
  use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/scatter-strata.dta", clear

  * Collapse and reshape data
  labelcollapse    essential correct cxr sputum dstgx s5_referral ///
      sp_drugs_tb sp_drugs_antibio sp_drugs_quin, by(sp_case)
  freeshape        essential correct cxr sputum dstgx s5_referral ///
      sp_drugs_tb sp_drugs_antibio sp_drugs_quin, i(sp_case) j(var)

  * Assign ordered number
  local x = 1
  gen order = 0

  qui foreach name in essential correct cxr sputum dstgx s5_referral ///
          sp_drugs_tb sp_drugs_antibio sp_drugs_quin {
          replace order = `x' if var_name == "`name'"
          local ++x
  }

 * Create graph
  graph dot var_value     ///
      ,                   ///
      asy over(sp_case) over(var_label, sort(order)) ///
      linegap(20)         ///
      graphregion(color(white)) ///
      xsize(7)            ///
      legend(region(lc(none) fc(none))) ///
      yscale(noline) ytit("") ylab(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%") ///
      linetype(line) lines( lp(.) lc(gs11)) ///
      legend(pos(5) ring(0) c(1) region(lc(white) fc(white))) ///
      marker(1, m(O) mlcolor(black)) ///
      marker(2, m(O) mlcolor(black)) ///
      marker(3, m(O) mlcolor(black)) ///
      marker(4, m(O) mlcolor(black)) ///
  title("Regression Coefficient plot", ///
      justification(center) color(black) span pos(17))

* Have a good day!
