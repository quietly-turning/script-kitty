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
	
	
	$(".table-block-container").click(function(){
		$(".table-block-container-active").removeClass("table-block-container-active");
		$(".columnCorral").hide();
		
		$(this).addClass("table-block-container-active");
		$(".columnCorral[data-table='" + $(this).attr("data-table") + "']").show();
	});
	
});