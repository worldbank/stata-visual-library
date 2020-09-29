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
		`""' _n ///
		`"  <script type="text/javascript">"' _n ///
		"  if (window.hljs) {" _n ///
		"    hljs.configure({languages: []});" _n ///
		`"    hljs.initHighlightingOnLoad();"' _n ///
		"    if (document.readyState && document.readyState === "`""complete""'") {" _n ///
		`"	  window.setTimeout(function() { hljs.initHighlighting(); }, 0);"' _n ///
		"	}" _n ///
		"  }" _n ///
		`"</script>"' _n ///
		`""' _n ///
		`"<script type="text/javascript">"' _n ///
		"  jQuery(document).ready(function(){" _n ///
		`"	  jQuery("#stata").load("https://raw.githubusercontent.com/worldbank/stata-visual-library/master/Library/`1'.html");"' _n ///
		"  });" _n ///
		`"</script>"' _n ///
		`""' _n ///
		`""' _n ///
		`"<script type="text/javascript">"' _n ///
		"if (window.hljs) {" _n ///
		`"  hljs.configure({languages: []});"' _n ///
		`"  hljs.initHighlightingOnLoad();"' _n ///
		"  if (document.readyState && document.readyState === "`""complete""' ") {" _n ///
		`"	window.setTimeout(function() { hljs.initHighlighting(); }, 0);"' _n ///
		"  }" _n ///
		"}" _n ///
		`"</script>"' _n ///
		`""' _n ///
		`"<style>"' _n ///
		`""' _n ///
		`".em {font-weight:bold;}"' _n ///
		`"pre, code {font-family: "lucida console", monospace;}"' _n ///
		`"pre.stata {font-size:13px; line-height:13px;}"' _n ///
		`"pre {padding:8px; border:1px solid #c0c0c0; border-radius:8px; background-color:#fdfdfd;}"' _n ///
		`"code {color:#3366cc; background-color:#fafafa;}"' _n ///
		`"pre code { color:black; background-color:white}"' _n ///
		`"</style>"' _n ///
		`""' _n ///
		`"  <title>`1'</title>"' _n ///
		`"  <style>"' _n ///
		`"	  code{white-space: pre-wrap;}"' _n ///
		`"	  span.smallcaps{font-variant: small-caps;}"' _n ///
		`"	  span.underline{text-decoration: underline;}"' _n ///
		`"	  div.column{display: inline-block; vertical-align: top; width: 50%;}"' _n ///
		`"  </style>"' _n ///
		`"  <!--[if lt IE 9]>"' _n ///
		`"	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js"></script>"' _n ///
		`"  <![endif]-->"' _n ///
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
		`""' _n ///
		`"    <pre class="stata"> "' _n ///
		`"      <div id="stata"></div>"' _n ///
		`"    </pre>"' _n ///
		`"  </div> "' _n ///
		`"<img src="figure/`1'.png">"' _n ///
		`""' _n ///
		`" </div>"' _n ///
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
		`"</html>"'

	file close 		`webpage'
	
	copy "`htmlfile'" "${GH}/docs/`1'.html", replace
