$(function(){
	
	var myTextArea = document.getElementById("query_raw_sql");
	
	// ensure that we found a textarea
	// (participants using the visual builder will not)
	if (myTextArea != null)
	{
		var myCodeMirror = CodeMirror.fromTextArea(myTextArea, {
			mode: "text/x-mariadb",
			lineNumbers: true,
			theme: "lesser-dark"
		});	
	}
	
	$('#exercise-footer').height(function(index, height) {
	    return window.innerHeight - $(this).offset().top;
	});
	
	$( window ).resize(function() {
		$('#exercise-footer').height(function(index, height) {
		    return window.innerHeight - $(this).offset().top;
		});
	});
	
	$("input[name='table']").change(function(){
		$(".table-block-active").removeClass("table-block-active");
		$(this).parents(".table-block").addClass("table-block-active");
	});
	
});