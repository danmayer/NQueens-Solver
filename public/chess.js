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

  $('.solve_forms').submit(function() {
    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function(data) {
	var results_data = JSON.parse(data);
	placeQueens(results_data['found']);
	//{:found => @inst_prob.found, :successors => @succs, :goal_tests => @goal_testsm, :states => @states}
	$('#results').html("<table class='table table-bordered'><tr><td>successors</td><td>goal tests</td><td>states</td><td>found</td></tr><tr><td>"+ results_data['successors'] +"</td><td>"+ results_data['goal_tests'] +"</td><td>"+ results_data['states'] +"</td><td>" + "true" + "</td></tr></table>");
	$('#results').show();
      }
    });
    return false;
  });

});

