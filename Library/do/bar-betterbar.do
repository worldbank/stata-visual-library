* 	Figure: Side by side horizontal bar plot (Active ingredients in drugs given for each case) using betterbar

/* 
	Data Source:
	---------------------
	Satyanarayana S, Kwan A, Daniels B, Subbaraman R, McDowell A, Bergkvist S, Das RK, Das V, Das J, Pai M. 
	Use of standardised patients to assess antibiotic dispensing for tuberculosis by pharmacies in urban India: 
	A cross-sectional study.  The Lancet Infectious Diseases. 2016 Nov 30;16(11):1261-8.
	
	Install Packages (if needed)
	-----------------------------
	We need two packages to run this file: betterbar, and grc1leg
	Please remove "*" from below lines if you have not installed them and would like to install.
*/

	* ssc install betterbar
	* net install grc1leg, from(http://www.stata.com/users/vwiggins)
   
    global  graph_opts ///
            note(, justification(left) color(black) span pos(7)) ///
            title(, justification(center) color(black) span pos(17)) ///
            subtitle(, justification(left) color(black) span pos(11)) ///
            graphregion(color(white)) ///
            ylab(,angle(0) nogrid) ///
            ytit("") ///
            xtit(,placement(left) justification(left)) ///
            yscale(noline) xscale(noline) xsize(7) ///
            legend(region(lc(none) fc(none)))
        
    qui do "https://github.com/worldbank/stata-visual-library/raw/master/Library/ado/betterbar.ado"
    qui do "https://github.com/worldbank/stata-visual-library/raw/master/Library/ado/labelcollapse.ado"

    local n_5 = 599
    local n_6 = 601
    
    local title_5 = "Classic case of presumed TB"
    local title_6 = "TB case with positive sputum report"

    qui forvalues i = 5/6 {
    
        local case = `i' - 4

        use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-betterbar.dta" , clear
            
        gen n = 1
        bys med_generic: egen med_class_typ = mode(med_class), minmode // Label with most typical medicine code
        label val med_class_typ med_k
                
        keep if case == `i'
            
        labelcollapse  (firstnm) n med_class_typ med_generic_encoded sp_location, ///
                        by(med_generic facilitycode) ///
                        vallab(med_class_typ med_generic_encoded sp_location)
            
        labelcollapse   (sum) n (firstnm) med_generic_encoded med_class_typ, ///
                        by(med_generic) ///
                        vallab(med_class_typ med_generic_encoded) 
            
        cap separate n, by(med_generic_encoded) shortlabel
                
        foreach var of varlist n?* {
            
            local theLabel : var label `var'
            local theLabel = regexr("`theLabel'","med_generic_encoded == ","")
                    
            cap su n if med_generic == "`theLabel'"
            cap local theN = `r(mean)'
                    
            label var `var' "`theLabel' [`theN']"
        }
                    
        foreach var of varlist n?* {
            
            replace `var' = . if `var' < 5 // Exclude low volumes
            replace `var' = `var'/`n_`i'' // Number of interactions
            qui sum `var'
            if `r(N)' == 0 drop `var' 
        }
                
        drop if med_generic == "Sodium Chloride" // not an active ingredient
            
        betterbar (n?*) , ///
                stat(sum) over(med_class_typ) by(med_class_typ) nobylabel nobycolor d(1)  ///
                legend(span c(1) pos(3) ring(1) symxsize(small) symysize(small) size(small))  ///
                dropzero ///
                xlab(0 "0%" .2 "20%" .4 "40%" .6 "60%") ///
                ysize(6) labsize(2) ///
                ${graph_opts} ///
                title("Case `case' (N=`n_`i'')") subtitle("`title_`i''") ///
                name(figure_4_`case')
            
        }
        
    grc1leg figure_4_1 figure_4_2 ///
            , ///
			title("Side by Side Bar Plot", justification(center) color(black) span pos(17)) ///
            pos(3) ///
            graphregion(color(white)) ///
            xsize(7) 
	
* Have a lovely day!
