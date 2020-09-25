*Writing titles to textfile

	*Create a temporary textfile
	tempname 	webpage
	tempfile	htmlfile

	*Write the title rows defined above
	cap file close 	`webpage'
	file open  		`webpage' using "`htmlfile'", text write replace
	file write  	`webpage' ///
		`"<!DOCTYPE html>"' _n ///
		`""' _n ///
		`"<html>"' _n ///
		`""' _n ///
		`"<!--HEAD -->"' _n ///
		`"<head>"' _n ///
		`""' _n ///
		`"  <meta charset="utf-8" />"' _n ///
		`"  <meta http-equiv="X-UA-Compatible" content="IE=EDGE" />"' _n ///
		`"  <meta name="viewport" content="width=device-width, initial-scale=1" />"' _n ///
		`""' _n ///
		`"  <title>Stata Visual Library</title>"' _n ///
		`""' _n ///
		`"  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js""' _n ///
		`"    integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q""' _n ///
		`"    crossorigin="anonymous">"' _n ///
		`"  </script>"' _n ///
		`""' _n ///
		`"  <link rel="stylesheet""' _n ///
		`"    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css""' _n ///
		`"    integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z""' _n ///
		`"    crossorigin="anonymous">"' _n ///
		`""' _n ///
		`"  <link rel="stylesheet" href="site_libs/bootstrap-3.3.5/css/cerulean.min.css">"' _n ///
		`"  <link rel="stylesheet" href="site_libs/custom-css.css">"' _n ///
		`""' _n ///
		`"  <script"' _n ///
		`"    src="https://code.jquery.com/jquery-3.5.1.min.js""' _n ///
		`"    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=""' _n ///
		`"    crossorigin="anonymous""' _n ///
		`"    onload="loaded=true; console.log(loaded)">"' _n ///
		`"  </script>"' _n ///
		`""' _n ///
		`"  <script type="text/javascript">"' _n ///
		"    jQuery(document).ready(function(){" _n ///
		`"        jQuery("#contain").load("https://raw.githubusercontent.com/worldbank/stata-visual-library/master/docs/header.html");"' _n ///
		"    });" _n ///
		`"  </script>"' _n ///
		`""' _n ///
		`"  <script type="text/javascript">"' _n ///
		"    $(function () {" _n ///
		`"      $("' "'" `"[data-toggle="tooltip"]"' "'" `").tooltip()"' _n ///
		"    })" _n ///
		`"  </script>"' _n ///
		`""' _n ///
		`"  <script type="text/javascript">"' _n ///
		"  if (window.hljs) {" _n ///
		"    hljs.configure({languages: []});" _n ///
		`"    hljs.initHighlightingOnLoad();"' _n ///
		"    if (document.readyState && document.readyState ===" `""complete""' ") {" _n ///
		"      window.setTimeout(function() { hljs.initHighlighting(); }, 0);" _n ///
		"    }" _n ///
		"  }" _n ///
		`"  </script>"' _n ///
		`""' _n ///
		`"</head>"' _n ///
		`""' _n ///
		`"<!-- BODY -->"' _n ///
		`"<body>"' _n ///
		`""' _n ///
		`"  <!-- Upper row -->"' _n ///
		`"  <div id="contain"></div>"' _n ///
		`""' _n ///
		`"  <!-- Content -->"' _n ///
		`"  <div class="container-fluid main-container">"' _n ///
		`"    <script type="text/javascript">"' _n ///
		`""' _n ///
		"      var plots = [" `"${`1'}"' "];" _n ///
		"" _n ///
		"       for(var i = 0; i < plots.length; i++) {" _n ///
		"         document.write('<div class=" `""col-sm-6""' ">');" _n ///
		"         document.write('<div class=" `""card""' "data-toggle=" `""tooltip""' "data-placement=" `""bottom""' "title=" `""Click on image to see the code""' ">');" _n ///
		"         document.write('<a href=" `"""' "' + plots[i] + '.html" `"""' "class=" `""stretched-link""' "></a>');" _n ///
		"         document.write('<div class=" `""card-body""' ">');" _n ///
		"         document.write('<img class=" `""card-img""' "src=" `""figure/"' "' + plots[i] +'.png" `"""' ">');" _n ///
		"         document.write('</div></div></div>');" _n ///
		"       }" _n ///
		`"    </script>"' _n ///
		`"  </div>"' _n ///
		`"<!-- dynamically load mathjax for compatibility with self-contained -->"' _n ///
		`"<script"' _n ///
		`"  src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js""' _n ///
		`"  integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN""' _n ///
		`"  crossorigin="anonymous">"' _n ///
		`"</script>"' _n ///
		`"<script"' _n ///
		`"  src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js""' _n ///
		`"  integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV""' _n ///
		`"  crossorigin="anonymous">"' _n ///
		`"</script>"' _n ///
		`""' _n ///
		`"</body>"' _n ///
		`"</html>"' _n
			
	file close 		`webpage'
		
	copy "`htmlfile'" "${GH}/docs/`1'.html", replace
