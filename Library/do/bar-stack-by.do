/*  
  Figure: Stack bar graph by two variables (Drug use by referral decisions for two standardised patient cases)

	Data Source:
	---------------------

	Satyanarayana S, Kwan A, Daniels B, Subbaraman R, McDowell A, Bergkvist S, Das RK, Das V, Das J, Pai M. 
	Use of standardised patients to assess antibiotic dispensing for tuberculosis by pharmacies in urban India: 
	A cross-sectional study. The Lancet Infectious Diseases. 2016 Nov 30;16(11):1261-8.


	Install Packages (if needed)
	-----------------------------
	We need one packages to run this file: grc1leg
	Please remove "*" from below lines if you have not installed it and would like to install.
*/

	* net install grc1leg, from(http://www.stata.com/users/vwiggins)

  global graph_opts1 bgcolor(white) graphregion(color(white)) legend(region(lc(none) fc(none))) ylab(,angle(0) nogrid) subtitle(, justification(left) color(black) span pos(11))  title(, justification(center) color(black) span pos(17))
  global pct `" 0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%" "'

  use "https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-stack-by.dta", clear

  graph bar med_b2_antister_cat?? ///
      if dr_3 == 1 ///
      , ///
      stack over(checkgroup) nofill ///
      ylab(${pct}) ///
      legend(order(5 "No Medication" ///
                   4 "Antibiotic and Steroid" ///
                   3 "Antibiotic" ///
                   2 "Steroid" ///
                   1 "No Antibiotic or Steroid") ///
       c(1) pos(3) ///
       symxsize(small) symysize(small) size(small)) ///
      ${graph_opts1} ///
      bar(5, color(white) lc(black) lp(solid) lw(thin)) ///
      bar(1,lw(thin) lc(black)) bar(2,lw(thin) lc(black)) ///
      bar(3,lw(thin) lc(black)) bar(4,lw(thin) lc(black)) ///
      subtitle("Referral", color(black) justification(center) pos(12)) ///
      name(figure_1)
  
  graph bar med_b2_antister_cat?? ///
      if dr_3 == 0 ///
      , ///
      stack over(checkgroup) nofill ///
      ylab(${pct}) ///
      legend(order(5 "No Medication" ///
               4 "Antibiotic and Steroid" ///
               3 "Antibiotic" ///
               2 "Steroid" ///
               1 "No Antibiotic or Steroid") ///
         c(1) pos(3) ///
         symxsize(small) symysize(small) size(small)) ///
      ${graph_opts1} ///
      bar(5, color(white) lc(black) lp(solid) lw(thin)) ///
      bar(1,lw(thin) lc(black)) ///
      bar(2,lw(thin) lc(black)) ///
      bar(3,lw(thin) lc(black)) ///
      bar(4,lw(thin) lc(black)) ///
      subtitle("No Referral", color(black) justification(center) pos(12)) ///
      name(figure_2)

  grc1leg figure_2 figure_1 ///
      , ///
  title ("Stack Bar Chart") ///
      pos(3) ///
      graphregion(color(white)) ///
      xsize(7) ///
      rows(1) ///
      leg(figure_2)

* Have a lovely day!
