$(document).on("page:change", function(){

	// this seems hackish...
	var code_mirror = document.getElementsByClassName("CodeMirror");
	var raw_sql = document.getElementsByClassName("raw-sql");
	var myCodeMirror;

	var simple_editor = document.getElementById("query_raw_sql");

	// ensure that we've found an editable textarea
	// (participants using the visual builder will not)
	if (simple_editor != null && code_mirror.length == 0)
	{
		myCodeMirror = CodeMirror.fromTextArea(simple_editor, {
			mode: "text/x-mariadb",
			lineNumbers: true,
			theme: "lesser-dark",
		});
	}

	// ensure that we've found at least one textarea intended for displaying static code
	if (raw_sql != null && code_mirror.length == 0)
	{
		// a page can have multiple instances of these
		for (i=0; i < raw_sql.length; i++ ) {

			var myCodeMirror = CodeMirror.fromTextArea( raw_sql[i], {
				mode: "text/x-mariadb",
				lineNumbers: true,
				theme: "xq-light",
				readOnly: "nocursor",
			});
		}
	}

});