* Figure: Horizontal bar plot with grouping of variables, standard error bars, and cross-group comparisons

* Replication file for:
* Satyanarayana S, Kwan A, Daniels B, Subbaraman R, McDowell A, Bergkvist S, Das RK, Das V, Das J, Pai M. 
* Use of standardised patients to assess antibiotic dispensing for tuberculosis by pharmacies in urban India: 
* A cross-sectional study. 
* The Lancet Infectious Diseases. 2016 Nov 30;16(11):1261-8.
	

    global pct `" 0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%" "'

    ssc install betterbar

    use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-better-ci.dta", clear

    betterbar ///
        (dr_3 correct_treatment)  ///
        (med_b2_any_antibiotic med_b2_any_steroid med_b2_any_antister med_l_any_2 med_b2_any_schedule_h med_b2_any_schedule_h1 med_b2_any_schedule_x med_l_any_1)   ///
        , ///
        over(city) xlab($pct) ci pct ///
        legend(on span pos(12) ring(1) r(1) symxsize(small) symysize(small) region(lc(none))) ///
        ysize(6) n barlab scale(.8)
		
* Have a lovely day!
