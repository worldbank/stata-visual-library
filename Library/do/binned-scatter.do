/* 	
  Figure: Binned scatter plot

	Data Source:
	---------------------
	Jishnu Das, Benjamin Daniels, Monisha Ashok, Eun-Young Shim, and Karthik Muralidharan
	Two Indias: The structure of primary health care markets in rural Indian villages with implications for policy.
  doi: https://doi.org/10.1016/j.socscimed.2020.112799
  repo: https://github.com/bbdaniels/ssm-rhcp-2020
*/

  use "https://github.com/worldbank/stata-visual-library/blob/develop/Library/data/binned-scatter.dta?raw=true" , clear

  count
  recode s1q15 (-99 = .)
  count if s2q15 != . & s2q16 != .

  // Adjust number of patients for public clinics
  egen group = group(private mbbs) , label
      replace group = 2 if group == .
  bys finclinid: gen n = _N
   bys stateid finclinid_new: gen ndocs = _N
   replace patients = patients/ndocs if public == 1
	gen check = patients
    drop if (check > 120 | s2q16 == 0)

  // bin minutes per patient and calculate hours per day
  recode s2q16 (1/5 = 5)(6/10 = 10)(11/15 = 15)(16/20 = 20)(26/max=30) , gen(minpp)
  gen hours = check*s2q16/60
    gen pct = hours / 6
    mean hours pct patients s2q16 [pweight = weight_psu] , over(group) // average utilization

  // Graph
  replace minpp = minpp+1 if group == 1 // Public MBBS
  replace minpp = minpp-1 if group == 2 // Private non-MBBS

  local opts lc(gray) lw(thin)

  isid uid , sort
  version 13

  gen blank = .

  tw                                                                    ///
    /// Invisible cheaters for legend
    (scatter blank blank in 1 , m(.) mc(black) msize(*2))               ///
    (scatter blank blank in 1 , m(T) mc("0 109 219") msize(*4))         ///
    (scatter blank blank in 1 , m(S) mc("146 0 0") msize(*4))           ///
    /// Actual graph points
    (scatter check minpp if private == 1 & mbbs == 0,                   ///
        jitter(2) jitterseed(382375) m(.) mc("0 0 0") msize(*.1))       ///
    (scatter check minpp if private == 1 & mbbs == 1,                   ///
        jitter(2) jitterseed(382375) m(T) mc("0 109 219") msize(*.4))   ///
    (scatter check minpp if private == 0 & mbbs == 1,                   ///
        jitter(2) jitterseed(382375) m(S) mc("146 0 0") msize(*.4))     ///
    /// Reference line
    (function 72, range(3 7.5) `opts')          ///
    (pci 36 7.5 72 7.5 , `opts')                ///
    (function 36, range(7.5 12.5) `opts')       ///
    (pci 36 12.5 24 12.5 , `opts')              ///
    (function 24, range(12.5 17.5) `opts')      ///
    (pci 24 17.5 18 17.5 , `opts')              ///
    (function 18, range(17.5 22.5) `opts')      ///
    (pci 18 22.5 14.4 22.5 , `opts')            ///
    (function 14.4, range(22.5 27.5) `opts')    ///
    (pci 14.4 27.5 12 27.5 , `opts')            ///
    (function 12, range(27.5 32) `opts')        ///
    (scatteri 12 32 "6 Hour Workday" , m(none) mlabc(gray)) ///
    (scatteri 12 40  , m(none) mlabc(gray))     ///
    ,  /// Design options
    legend(r(1) on order(1 "Private Non-MBBS" 2 "Private MBBS" 3 "Public MBBS"))    ///
    xtit("Minutes per Patient {&rarr}")  ytit("Patients per Provider Day")          ///
    xlab(5 ":05" 10 ":10" 15 ":15" 20 ":20" 25 ":25" 30 ":30+" , notick)            ///
    legend(region(lc(none) fc(none))) xtit(,placement(left) justification(left))

* Have a lovely day!
