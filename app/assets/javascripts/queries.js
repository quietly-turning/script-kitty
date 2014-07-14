// ----------------------------------------------------------------------------
// ------------------   jQuery functions and etc are below   ------------------
// ----------------------------------------------------------------------------


$(document).ready(function(){

	$('#new_query').on("submit", function()
	{
	
		$('.condition').each(function()
		{
			var i = 1;
		
			// for each of the hidden inputs in that this condition
			$(this).find('input:hidden').not("script").each(function(){
				// the first iteration SHOULD be the column
				// the second iteration SHOULD be the operator
				// the third iteration SHOULD be the complexOperator (could be empty, of course)
				if (i == 1)
				{
					$(this).val($(this).parents('.condition').find('.columnBlock').text());
				}
				if (i == 2)
				{
					$(this).val($(this).parents('.condition').find('.operatorBlock').attr("oid"));
				}
				if (i == 3)
				{
					$(this).val($(this).parents('.condition').find('.complexOperatorBlock').text());
				}
				i += 1;
			});
		});

	});

	// ----------------------------------------------------------------------------
	//  Query Builder
	// ----------------------------------------------------------------------------

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
	// - - - - - - - - - - - - - - INITIALZE DRAG & DROP - - - - - - - - - - - - - - - 
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   

	function initialize()
	{
		initializeDraggable();
		initializeDroppable();
		resortConditions();
	}

	function newCondition()
	{
		$.get("/queries/new.js", function(){
			initialize()
		});
	}

	initialize();
	
	var poofX;
	var poofY;
	$(document).mousemove(function(e){
		// where are these numerical offset values coming from?
		// trial, error, and guesswork, my friend
		poofX = e.pageX - 80;
		poofY = e.pageY - 80;
	}); 


	function animatePoof(){
		$('#poof').css({left:poofX , top:poofY});
		$('#poof').sprite({fps:15, no_of_frame: 5, play_frames: 5}).show().delay(250).fadeOut(40);
	}


	function initializeDraggable()
	{
		$('.draggable').each(function(){
			
			$(this).draggable({
				snap:   "." + $(this).data("blockType") + "Acceptor",
				
				// if the draggable block has yet to be dropped, clone it
				// if the draggable bloack has already been dropped, empty string (just drag it)
				helper: $(this).data('dropped') ? "" : "clone",
				
				cursor: "move",
				containment: '#content',
				
				revert: "invalid"
					
					// if ($(this).data('dropped'))
					// {
					// 	// the user is (probably) trying to get rid of it now...
					// 	$(this).remove();
					//  animatePoof();
					//
					// 	if ($(this).data("blockType") == "or" || $(this).data("blockType") == "and")
					// 	{
					// 		// the user is (probably) trying to get rid of an "and" or "or" now...
					// 		// fadeOut, remove .condition class, strip condition's ID, strip each child element's ID
					// 		$(this).parents('.condition').fadeOut().removeClass('condition').attr("id", "").find("*").attr("id", "");
					// 		resortConditions();
					// 	}
					//
					// } else {
					// 	return "invalid"
					// }
			});
		});
	}


	function initializeDroppable()
	{
		 $('.dropHere').each(function(){
			 
	 		$(this).droppable({ 	
	 			accept: "." + $(this).data("accepts"),
	 			drop: function( event, ui )
	 			{
					ui.helper.data("dropped", true);
					
					// clear the absolute position jquery sets
					// and replace it with a font-size hack
					// (I can't figure out what CSS is causing dropped blocks to grow in font-size...)
	 				ui.helper.attr("style", "font-size:0.8em;");
	 				
					$(this).append(ui.helper.clone());
					
					
					var droppedtype = ui.helper.context.dataset.blocktype;
					
	 				if (droppedtype == "or" || droppedtype == "and")
	 				{	
						if (droppedtype == "or")
						{							
	 						// add margin-bottom: -11px;
	 						$(this).parents(".condition").attr("style", "margin-bottom:-11px;");
							
							//we just dropped an "or" so remove the "and" from this condition
							$(this).parents(".container").children(".toprow").children(".end").children(".dropHere").remove();
							$(this).parents(".condition").addClass("condition-with-or").removeClass("condition-with-both");
							
						} else if (droppedtype == "and") {			
							
							//we just dropped an "and" so remove the "or" (bottom)row from this condition
							$(this).parents(".container").children(".bottomrow").remove();
							
	 						// add margin-bottom: -42px;
	 						$(this).parents(".condition").attr("style", "margin-bottom:-42px;");
							$(this).parents(".condition").addClass("condition-with-and").removeClass("condition-with-both");
						}
 						newCondition();
	 				}
					
					
					if ($(this).hasClass("selectAcceptor"))
					{
						$("#select").append('<div class="dropHere columnAcceptor selectAcceptor" data-accepts="column-block"></div><br>');
						initializeDroppable();
					}
					
	 				checkIfConditionIsComplete();

	 			}
	 		});
		 });
	}

		// if we are editing a query (as opposed to creating one) the hidden fields for
		// col_id and operator will already have values, so grab them, and use each in
		// visually initializing the edit page, with blocks placed appropriately
		// 
		// these two if-statements need to be declared beneath the draggable/droppable declarations (above)
		// which would otherwise nullify any selective disabling we might be attempting here
		// 
		// 
		// if ($('#query_condition_animal_attr').val() != "" && $('#query_condition_animal_attr').val() != undefined)
		// {
		// 	var coff = $("#columnAcceptor").offset();
		// 		
		// 	$('.columnBlock').each(function(){
		// 		if ($(this).attr('cid')==$('#query_condition_animal_attr').val())
		// 		{
		// 			$(this).offset({top:0,left:0}).offset({top:coff.top,left:coff.left});
		// 		} else {
		// 			$(this).draggable('disable');
		// 		}
		// 	});
		// }
		// 
		// if ($('#query_condition_operator_id').val() != "" && $('#query_condition_operator_id').val() != undefined)
		// {	
		// 	var ooff = $("#operatorAcceptor").offset();
		// 	
		// 	$('.operatorBlock').each(function(){
		// 		if ($(this).attr('oid') == $('#query_condition_operator_id').val())
		// 		{
		// 			$(this).offset({top:0,left:0}).offset({top:ooff.top,left:ooff.left});
		// 		} else {
		// 			$(this).draggable('disable');
		// 		}
		// 	});
		// 
		// }
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
	// - - - - - - - - - functions for recycling blocks  - - - - - - - - - - - - - - -
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
	
		// some sort of more "official" sorting algorithm needs to be implemented here...
		function resortConditions()
		{		
		
			var i = 1;
			
			$('.condition').each(function(){		
							
				$(this).find('input:hidden').not("script").each(function(){
					$(this).attr("id", $(this).attr("id").replace("_0_", "_" + i + "_"));
				});
				
				i++;
			});	
		}
	
		function checkIfConditionIsComplete(condition)
		{		
			if ($(condition).children('.columnAcceptor').children('.columnBlock').length > 0 && $(condition).children('operatorAcceptor').children('operatorBlock').length > 0)
			{
				$(condition).children('.buildYourQuery').addClass('completedCondition');
			} else {
				$(condition).children('.buildYourQuery').removeClass('completedCondition');
			}
		}
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
});