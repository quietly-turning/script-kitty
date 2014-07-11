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

	$.get("/queries/new.js", function(){
		initializeColumnDrag();
		initializeOperatorDrag();
		initializeColumnDrop();
		initializeOperatorDrop();
		initializeComplexOperatorDrag();
		initializeComplexOperatorDrop();
		resortConditions();
	});


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



	function initializeColumnDrag()
	{
		$('.columnBlock').each(function(){
			// if the columnBlock has already been dropped into an acceptor once
			if ($(this).data('dropped'))
			{
				$(this).draggable({
					snap:   ".columnAcceptor",	
					cursor: "move",
					containment: '#content',
					revert: function(e)
					{  
						// the user is (probably) trying to get rid of it now...
						$(this).remove();
	 				   	animatePoof();
					}		
				});
			} else {
				$(this).draggable({	
					snap: '.columnAcceptor',
					helper: "clone",
					cursor: "move",
					containment: '#content',
					revert: "invalid"
				});
			}
		});
	}

	function initializeOperatorDrag()
	{
		$('.operatorBlock').each(function(){
			if ($(this).data('dropped'))
			{
				$(this).draggable({
					snap:   ".operatorAcceptor",	
					cursor: "move",
					containment: '#content',
					revert: function(e)
					{  
						// the user is (probably) trying to get rid of it now...
						$(this).remove();
	 				   	animatePoof();
					}		
				});
			} else {
				$(this).draggable({	
					snap: '.operatorAcceptor',
					helper: "clone",
					cursor: "move",
					containment: '#content',
					revert: "invalid"
				});
			}
		});
	}



	function initializeColumnDrop()
	{
		$('.columnAcceptor').droppable({ 	
			accept: '.columnBlock',
			drop: function( e, ui )
			{
				var columnClone = ui.helper.clone();
				columnClone.data('dropped', true);
				$(this).append(columnClone);
									
				checkIfConditionIsComplete($(this).parents('.condition'));
				initializeColumnDrag();
			}
		});
	}


	function initializeOperatorDrop()
	{	
		$('.operatorAcceptor').droppable({
			accept: '.operatorBlock',
			drop: function( event, ui )
			{
				var operatorClone = ui.helper.clone();
				operatorClone.data('dropped', true);
				$(this).append(operatorClone);
			
				checkIfConditionIsComplete($(this).parents('.condition'));
				initializeOperatorDrag();
			},
		});
	}


	function initializeComplexOperatorDrag()
	{
		$('.complexOperatorBlock').each(function(){
			if ($(this).data('dropped'))
			{
				$(this).draggable({
					snap:   ".complexOperatorAcceptor",	
					cursor: "move",
					containment: '#content',
					revert: function(e)
					{  
						$(this).hide();
						animatePoof();
					
						// This would be much, much cleaner/simpler if we could simply .remove() the old condition.
						// Errors abound, however, so I'm left simply stripping all IDs and classes from it...
						// 
						// the user is (probably) trying to get rid of it now...
						// fadeOut, remove .condition class, strip condition's ID, strip each child element's ID
						$(this).parents('.condition').fadeOut().removeClass('condition').attr("id", "").find("*").attr("id", "");		
						resortConditions();
					
					}		
				});
			} else {
				$(this).draggable({	
					snap: '.complexOperatorAcceptor',
					helper: "clone",
					cursor: "move",
					containment: '#content',
					revert: "invalid"
				});
			}
		});
	}


	function initializeComplexOperatorDrop()
	{			
		$('.complexOperatorAcceptor').droppable({
			accept: '.complexOperatorBlock',
			tolerance: 'fit',
			drop: function( event, ui )
			{	
				// hide the dashed-line shape
				$(event.target).removeClass('preDrop');
			
				// handle block cloning
				var complexOperatorClone = ui.helper.clone();
				complexOperatorClone.data('dropped', true);
				$(this).append(complexOperatorClone);
						
				if ($(this).data('dropped') === undefined)
				{
					// this is the first time it is dropped
					$(this).data('dropped', true);
				
					$.get('/queries/new.js', function(){
						initializeColumnDrop();
						initializeOperatorDrop();
						initializeComplexOperatorDrag();
						initializeComplexOperatorDrop();
						resortConditions();
					});
				
				} else {
					// this is for subsequent drops...
				}
			
				checkIfConditionIsComplete($(this).parents('.condition'));
			}
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
		function resortConditions(conditionBeingRemoved)
		{		
		
			var i = 1;	
			$('.condition').each(function(){		
				$(this).find('.buildYourQuery > legend').text('Condition #' + i); 
			
				// $(this).attr('id', 'condition' + i); 
				// 		
				// 			var newCA	= 'columnAcceptor' + i;
				// 			var newOA	= 'operatorAcceptor' + i;
				// 			var newCOA	= 'complexOperatorAcceptor' + i;
				// 			
				// 			$(this).find('div.columnAcceptor').attr("id", newCA);
				// 			$(this).find('div.operatorAcceptor').attr("id", newOA);
				// 			$(this).find('div.complexOperatorAcceptor').attr("id", newCOA);
			
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