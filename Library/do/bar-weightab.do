/* 
  Figure:	Side by side horizontal bar plot (Outcomes by City & Case) using weightab

	Data Source:
	---------------------

	Kwan, Ada, Benjamin Daniels, Vaibhav Saria, Srinath Satyanarayana, Ramnath Subbaraman, Andrew McDowell, Sofi Bergkvist et al.
	“Variations in the quality of tuberculosis care in urban India: a cross-sectional, 
	standardized patient study in two cities.” PLoS medicine 15, no. 9 (2018): e1002653.
*/

  global 	graph_opts                                        ///
    title(, justification(left) color(black) span pos(11))  ///
    graphregion(color(white) lc(white) lw(med) la(center))  /// <- remove la(center) for Stata < 15
    ylab(,angle(0) nogrid) xtit(,placement(left) justification(left)) ///
    yscale(noline) xscale(noline) legend(region(lc(none) fc(none)))

  local 	opts lw(thin) lc(white) la(center)

  label 	def case 1 "Case 1" 2 "Case 2" 3 "Case 3" 4 "Case 4" , modify

  qui do 	"https://github.com/worldbank/stata-visual-library/raw/master/Library/ado/weightab.ado"

  use 	"https://github.com/worldbank/stata-visual-library/raw/master/Library/data/bar-weightab.dta" , clear

  weightab /// Create Figure 1
      correct treat_cxr re_3 re_4 treat_refer t_12 ///
      med_any med_l_any_1 med_l_any_2 med_l_any_3  med_k_any_9   ///
      if city == 2 ///
      [pweight = weight_city] ///
      , ///
      ${graph_opts} ///
      barlab ///
      barlook(1 `opts' fi(100)) ///
      title("Patna") ///
      over(case) ///
      graph ///
      legend(off) ///
      xlab(${pct}) ///
      name(Fig_1_1)
  
  weightab /// Create Figure 2
      correct treat_cxr re_3 re_4 treat_refer t_12 ///
      med_any med_l_any_1 med_l_any_2 med_l_any_3  med_k_any_9  ///
      if city == 3 ///
      [pweight = weight_city] ///
      , ///
      ${graph_opts} ///
      barlab ///
      barlook(1 `opts'  fi(100)) ///
      title("Mumbai") ///
      over(case) ///
      graph ///
      legend(pos(5) ring(0) c(1) symxsize(small) symysize(small)) ///
      xlab(${pct}) ///
      name(Fig_1_2)
  
  graph combine Fig_1_1 Fig_1_2 /// Combine Figure 1 and 2
      , ///
  title("Side by Side Horizontal Barplot using weightab", justification(left) color(black) span pos(17)) ///
      ${comb_opts} ///
      xsize(7) r(1)

* Have a lovely day!
