* Figure 3: Chart of marginal effect with results table (Differences by city and qualification)

    global graph_opts ///
        title(, justification(left) color(black) span pos(11)) ///
        graphregion(color(white) lc(white) la(center)) /// <- remove la(center) for Stata < 15
        ylab(,angle(0) nogrid) xtit(,placement(left) justification(left)) ///
        yscale(noline) xscale(noline) legend(region(lc(none) fc(none)))

    global comb_opts ///
        graphregion(color(white) lc(white) la(center))


    qui do "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/ado/chartable.ado"
	
    use "https://github.com/worldbank/stata-visual-library/raw/develop-layout/Library/data/reg-panels.dta", clear

    chartable ///
        correct treat_cxr re_3 treat_refer med_any med_l_any_1 med_l_any_2 med_l_any_3  med_k_any_9  ///
        [pweight = weight_city] ///
        , ///
        ${graph_opts} ///
        rhs(type_formal 3.city i.case ) ///
        case0(Non-MBBS) case1(MBBS+) or command(logit) ///
        title("A. Differences by MBBS Qualification"), ///
		name(Fig_3_1.gph)

    chartable ///
        correct treat_cxr re_3 re_4 treat_refer med_any med_l_any_1 med_l_any_2 med_l_any_3  med_k_any_9  ///
        if type_formal == 0 ///
        [pweight = weight_city] ///
        , ///
        ${graph_opts} ///
        rhs(3.city i.case ) ///
        case0(Patna Non-MBBS) case1(Mumbai Non-MBBS) or command(logit) ///
        title("B. Non-MBBS Differences by City") ///
        name(Fig_3_2.gph)

    chartable ///
        correct treat_cxr re_3 re_4 treat_refer med_any med_l_any_1 med_l_any_2 med_l_any_3  med_k_any_9  ///
        if type_formal == 1 ///
        [pweight = weight_city] ///
        , ///
        ${graph_opts} ///
        rhs(3.city i.case ) ///
        case0(Patna MBBS+) case1(Mumbai MBBS+) or command(logit) ///
        title("C. MBBS Differences by City") ///
        name(Fig_3_3.gph)

    graph combine Fig_3_1 Fig_3_2 Fig_3_3 ///
        , ///
        ${comb_opts} ///
        xsize(5) c(1) ysize(6) altshrink

* Have a lovely day!
