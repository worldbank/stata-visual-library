/*==============================================================================

							  Virtual RT2
						   September 23, 2020
							 
					STATA MARKDOWN MASTER DO FILE
							 
==============================================================================*/
	
/*******************************************************************************
	PART 2: Set folder paths
*******************************************************************************/

	global	GH					"C:\Users\wb501238\Documents\GitHub\stata-visual-library"
	
/*******************************************************************************
	PART 3: Create document
*******************************************************************************/

	set scheme s2color
	
	* Copy the Stata style to the same folder as the markdown file to compile in PDF
	//copy https://www.stata-journal.com/production/sjlatex/stata.sty 	stata.sty
		
	global ScatterPlots		`""scatter-fl", "scatter-fl-ci", "scatter-poly-ci", "scatter-strata""'
	global BoxPlots			`""boxplot-pctile""'
	global LinePlots		`""line-fit-text""'
	global DensityPlots		`""density-av", "density-data", "density-shaded""'
	global RegressionCoef	`""reg-models", "reg-panels", "reg-chartable""'
	
	foreach category in ScatterPlots BoxPlots LinePlots DensityPlots RegressionCoef {
		
		do 		  "${GH}/Library/template-category-page.do" "`category'"
		tokenize `"${`category'}"'
		
		local n : word count "${`category'}"
	
		forvalues graph = 1(2)`n' {
		
		noi di "``graph''"
		
			gr drop _all
			do 			"${GH}/Library/do/``graph''.do"
			gr export 	"${GH}/docs/figure/``graph''.png", width(600) replace
			copy 		"${GH}/Library/do/``graph''.do" 	 "${GH}/Library/``graph''.html", replace
			do 			"${GH}/Library/template-plot-page.do" "``graph''"
		
		}
	}	
	
*============================== THE END =======================================*
