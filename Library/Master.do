/*==============================================================================

* STATA VISUAL LIBRARY MASTER DO FILE

==============================================================================*/
	
/*******************************************************************************
	PART 1: Set folder paths
*******************************************************************************/
    
  if ("`c(username)'" == "ifyou") {
      global	GH			"D:/Documents/RA Jobs/DIME/analytics/stata-visual-library"
  }

  if ("`c(username)'" == "atsu") {
      global GH  "/Users/atsu/Git/stata-visual-library"
  }
  
/*******************************************************************************
	PART 2: Create document
*******************************************************************************/

  // Set scheme color
	set scheme s2color
	
	* Copy the Stata style to the same folder as the markdown file to compile in PDF
	//copy https://www.stata-journal.com/production/sjlatex/stata.sty 	stata.sty
		
/* 	global ScatterPlots		`""binned-scatter","scatter-fl", "scatter-fl-ci", "scatter-poly-ci", "scatter-strata", "scatter-transparent""'
	global BoxPlots			  `""boxplot-pctile""'
	global BarPlots			  `""bar-better", "bar-betterbar", "bar-better-ci", "bar-over", "bar-stack-by", "bar-stack-cat", "bar-two-axes", "bar-counts", "bar-custombar", "bar-sorted", "confidence-intervals""'
	global LinePlots		  `""line-fit-text", "line-plottig", "line-uncluttered""'
	global DensityPlots		`""density-av", "density-data", "density-shaded""'
	global RegressionCoef	`""reg-models", "reg-chartable", "reg-het", "reg-predicted", "regression-fit""'
	global Map				    `""map-world""'
	global EventStudy		  `""eventstudy-prepost""'
	global ConfidenceInt  `""confidence-intervals""'
	global DotSummary     `""dot-summary""'
 */

  import delimited "${GH}/Library/content-summary.csv", varnames(1) clear

* Program
  do 	 "${GH}/Library/template-plot-page.do" // "`graph'" `"`tags'"' 
	do 	 "${GH}/Library/template-category-page.do" 
  levelsof graphtype, local(category)


	foreach category in `category' {
		 * levelsof graphname if graphtype == "`category'", local(graphlists) separate(",") clean
	    *categorypage, category(`category') graphlists(`"`graphlists'"')	
      levelsof graphname if graphtype == "`category'", local(graphs) clean
      local graphlists ""
      foreach graph of local graphs {
         if `"`graphlists'"' != "" local graphlists `"`graphlists', "'
                            local graphlists `"`graphlists'"`graph'""'
      }
      di `graphlists'
      categorypage, category(`category') graphlists(`"`graphlists'"')
	}

*		do 		    "${GH}/Library/template-category-page.do" "`category'"

  levelsof graphname, local(graphs)
  foreach graph in `graphs' {
  	do 	 "${GH}/Library/template-category-page.do" 
  	di "`graph'"
    levelsof tag if graphname == "`graph'", local(tags) clean
     *di "`tags'"

			mat drop _all
			gr drop _all
			
			set scheme s2color
	
			do 			    "${GH}/Library/do/`graph'.do"
			gr export 	"${GH}/docs/figure/`graph'.png", height(600) replace
			copy 		    "${GH}/Library/do/`graph'.do" 	 "${GH}/Library/`graph'.html", replace

			plotpage, graph(`graph') tags(`tags')
    import delimited "${GH}/Library/content-summary.csv", varnames(1) clear
  }

/*

	foreach file in "map-world.prj" "map-world.dbf" "map-world.shx" "map-world.shp" "world_shape.dta" "world_shape_coord.dta" {
    erase "${GH}/Library/`file'"
	}

*/
*============================== THE END =======================================*
