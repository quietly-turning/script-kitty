$(function(){
	
	var myTextArea = document.getElementById("query_raw_sql");
	
	// ensure that we found a textarea
	// (participants using the visual builder will not)
	if (!typeof myTextArea === "undefined" )
	{
		var myCodeMirror = CodeMirror.fromTextArea(myTextArea, {
			mode: "text/x-mariadb",
			lineNumbers: true,
			theme: "lesser-dark"
		});	
	}
	
});