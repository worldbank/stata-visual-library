/* 
  Figure: Line graph with uncluttered scheme

	Data Source:
	---------------------
	Stata built-in dataset: uslifeexp
	
	Install Scheme (if needed):
	---------------------
	Change scheme: scheme needs to be manually installed. Instruction on how
    to this can be found in https://gray.kimbrough.info/uncluttered-stata-graphs/
	Step 1: 	go to https://gray.kimbrough.info/uncluttered-stata-graphs/
	Step 2: 	click on "scheme" or go https://github.com/graykimbrough/uncluttered-stata-graphs/tree/master/schemes
	Step 3: 	Download two .scheme file in that github directionary
	Step 4: 	Place the .scheme file(s) in your Stata PERSONAL directory (if you dont know where, run "sysdir" in STATA Command)
	Step 5: 	run "set scheme uncluttered, permanent" in STATA Command
    

*/

  sysuse uslifeexp, clear
    set scheme uncluttered

  line le le_male le_female year       ///
      ,                                ///
       ytitle(Life expectancy (years)) ///
       legend(on                       /// Scheme supresses the legend by default
              order(1 "Overall"        /// Set label to show up in legend
                    2 "Male"           ///
                    3 "Female")        ///
              cols(3)                  /// Show all legends in one line (3 columns)
              pos(12))                 ///  Show legend on top of graph
        title("Line graph with uncluttered scheme",  justification(left) color(black) span pos(11))

* Have a lovely Day!

