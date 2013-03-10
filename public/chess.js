/* Set Count */

$(document).ready(function() {
  var position = $("#chess_board").position();

	/* Get board dimensions */
	var board = $('#chess_board');
	board = {
		width : board.width(),
		height : board.height()
	}
	
	/* Make pieces draggable */
	$('#chess_board a').live('mousedown', function() {
		
		var object = $(this);
		var class_array = $(this).attr('class').split(' ');
		
		//element(object,class_array);
		
		return false;
		
	}).draggable({	  
	  containment: [position.left+80,position.top,position.left+80+board.width,position.top+board.height],
		grid: [80, 80],
		zIndex: 1000
	}).each(function(i, item){
	
		var piece = $(item).attr('class').split(' ');
		var start_cell = $(item).parent().attr('id').split('');
		
		//init_game(piece, start_cell);
	
	});
});

