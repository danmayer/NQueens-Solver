$(document).ready(function() {
  var position = $("#chess_board").position();

	/* Get board dimensions */
	var board = $('#chess_board');
	board = {
		width : board.width(),
		height : board.height()
	}
	
	/* Make pieces draggable */
	$('#chess_board span').live('mousedown', function() {
		
		var object = $(this);
		//var class_array = $(this).attr('class').split(' ');
		
		//element(object,class_array);
		
		return false;
		
	}).draggable({	  
	  containment: [position.left+80,position.top,position.left+80+board.width,position.top+board.height],
		grid: [80, 80],
		zIndex: 1000
	}).each(function(i, item){
	
		var piece = $(item).attr('class').split(' ');
		var start_cell = $(item).parent().attr('id').split('');
	});

  function placeQueens(queen_positions) {
    console.log(queen_positions);
    var queen_string = "<span class='queen_piece'>&#9819;</span>";
    $('.queen_piece').remove();
    $.each(queen_positions, function(index, value) {
      console.log(index + ': ' + value);
      $($($('#chess_board tr')[index]).find('td')[value]).html(queen_string);
    });
  }

  placeQueens($("#chess_board").data('queens-positions'));

  $('#promblem_solver').submit(function() {
    $.ajax({
      type: "POST",
      url: $('#promblem_solver').attr('action'),
      data: $("#promblem_solver").serialize(),
      success: function(data) {
	var results_data = JSON.parse(data);
	placeQueens(results_data['results']);
      }
    });
    return false;
  });

});

