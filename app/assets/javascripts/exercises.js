$(function(){
	
	var myTextArea = document.getElementById("query_raw_sql");
	var myCodeMirror = CodeMirror.fromTextArea(myTextArea, {
		mode: "text/x-mariadb",
		lineNumbers: true,
		theme: "lesser-dark"
	});
	
});