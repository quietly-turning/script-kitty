$(function(){
	
	var simple_editor = $("#query_raw_sql")[0];
	var raw_sql = $(".raw-sql");
	
	// ensure that we found a textarea
	// (participants using the visual builder will not)
	if (simple_editor != null)
	{
		var myCodeMirror = CodeMirror.fromTextArea(simple_editor, {
			mode: "text/x-mariadb",
			lineNumbers: true,
			theme: "lesser-dark"
		});	
	}
	
	if (raw_sql != null)
	{
		
		// a page can have multiple instances of these		
		for (i=0; i < raw_sql.length; i++ ) {
			
			var myCodeMirror = CodeMirror.fromTextArea( raw_sql[i], {
				mode: "text/x-mariadb",
				lineNumbers: true,
				theme: "ambiance",
				readOnly: "nocursor",
			});
			
		}
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