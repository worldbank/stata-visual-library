/*
  Figure : Impact of provider qualifications on main standardized patient outcomes

	Data Source:
	--------------------------

	Das, Jishnu, Liana Woskie, Ruma Rajbhandari, Kamran Abbasi, and Ashish Jha.
	“Rethinking assumptions about delivery of healthcare: implications for universal health coverage.” Bmj 361 (2018).
	
	Install Library (if needed):
	---------------------------
	We need three packages to run this file: firthlogit, st0085_2 (estadd) , dm0037 (xml_tab)
	Please remove "*" from below lines if you have not installed them and would like to install.
*/
    * ssc inst firthlogit
    * net from http://www.stata-journal.com/software/sj14-2
    * net install st0085_2
    * net from  http://www.stata-journal.com/software/sj8-3
    * net install dm0037 
   
    /// Load adofiles
  * These files are created by the authors for the purposes of this study and are not publicly available for general use.
  * These files are not guaranteed to produce appropriate statistics other than those contained in this replication file.

  qui do "https: //github.com/worldbank/stata-visual-library/raw/master/Library/ado/chartablesheet.ado"

  use "https: //github.com/worldbank/stata-visual-library/raw/master/Library/data/reg-chartable.dta", clear
  
  /// Sample Restriction Logic
  global cxr "& sp_case <3"
  global sputum "& sp_case <3"
  global sp_drugs_tb "& sp_case >2"
      
  /// Output
  chartable correct cxr sputum s5_referral sp_drugs_tb sp_drugs_antibio sp_drugs_quin ///
  using "results.xlsx" ///
      , ///
      c(xi: firthlogit) ///
      rhs(q_mbbs pro_age pro_male patients_waiting_in i.sp_id) or p globalif ///
  title("Impact of provider qualifications on main standardized patient outcomes", justification(left) color(black) span pos(11))

* Have a lovely day!

