/*==============================================================================

							  Virtual RT2
						   September 23, 2020
							 
					STATA MARKDOWN MASTER DO FILE
							 
==============================================================================*/

/*******************************************************************************
	PART 0: Select sections to run
*******************************************************************************/

	local packages		0
	local paths			1
	local document		1

/*******************************************************************************
	PART 1: Install necessary packages
*******************************************************************************/

	if `packages' {
		
		* Install markstat to use Stata markdown
		ssc install markstat, replace

		* Install whereis to make markstat work
		ssc install whereis, replace
		
		* Install other commands we will use for this session
		ssc install estout, replace
		ssc install unique, replace
		
	}
	
/*******************************************************************************
	PART 2: Set folder paths
*******************************************************************************/

	if `paths' {

		* Tell Stata where to find the relevant programs :
		* On Mac/Linux, go to terminal and type "which pdflatex" and "which pandoc"
		* On Windows, go to the command prompt and type "where pdflatex" and "where pandoc"
		* Paste the respective results on the lines below
		whereis pdflatex 			"C:\Program Files\MiKTeX 2.9\miktex\bin\x64\pdflatex.exe"
		whereis pandoc 				"C:\Program Files (x86)\Pandoc\pandoc.exe"
		
		* Workshop folder
		global	GH					"C:\Users\wb501238\Documents\GitHub\stata-visual-library"
	}
	
/*******************************************************************************
	PART 3: Create document
*******************************************************************************/

	set scheme s2color
	
	* Copy the Stata style to the same folder as the markdown file to compile in PDF
	//copy https://www.stata-journal.com/production/sjlatex/stata.sty 	stata.sty
	
	local scatter	`""scatter-fl" "scatter-fl-ci" "scatter-poly-ci" "scatter-strata""'
	
	foreach graph in `scatter' {
		
		di `"`graph' "'
	
		gr drop _all
		do 			"${GH}/Library/do/`graph'.do"
		gr export 	"${GH}/docs/figure/`graph'.png", width(600) replace
		copy 		"${GH}/Library/do/`graph'.do" 	 "${GH}/Library/`graph'.html", replace
		do 			"${GH}/Library/template-html.do" "`graph'"
		filefilter  "${GH}/docs/`graph'.html" 		 "${GH}/docs/delete_me.html", from("\BS{") to ("{") replace
		filefilter  "${GH}/docs/delete_me.html" 	 "${GH}/docs/`graph'.html"	, from("\BS}") to ("}") replace
		erase		"${GH}/docs/delete_me.html"
	}
	
*============================== THE END =======================================*
