$(document).on('turbolinks:load', function(){

	var myCodeMirror;

	// find all instances of CodeMirror that already exist on the page (due to Turbolinks?)
	// if a CodeMirror instance already exists, don't add another!
	var code_mirror = document.getElementsByClassName("CodeMirror");

	// raw_sql is the class identifier used for CodeMirrors which display static code
	// there can be multiple of these on a single page
	var raw_sql = document.getElementsByClassName("raw-sql");

	// simple_editor is the identifier used for live, editable CodeMirror instances
	// there should only ever be one on a single page
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