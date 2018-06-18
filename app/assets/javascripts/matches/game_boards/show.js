$(document).ready(function(){

setTimeout(function()
{  
  var sizeCell = 50
  var adjust = 0
  var oldElem;
  var elem;

  var imgDraggable = $('.spacecraft-distribution').find('img') 

  var setPosition = function(parent, elem){
    $(parent).css({position: 'relative'})
    $(elem).css({position: 'absolute'})

    var dataRow = parseInt($(elem).attr('data-row'))
    var dataColumn = parseInt($(elem).attr('data-column'))

    var idCell = '#' + dataRow + '-' + dataColumn


    var topCell = $(idCell).offset().top //- sizeCell - adjust
    var leftCell = $(idCell).offset().left //- 0

    $(elem).offset({left: leftCell, top: topCell})
  }

  var getImages = function(){
    var spacecrafts = $('.spacecraft-distribution').find('img')
    for(var i = 0; i < spacecrafts.length; i++){
      setPosition($('.spacecraft-distribution'), spacecrafts[i])
    }
  }

  var createPosition = function(spacecraft, row, column){
    $.ajax({
      type: 'POST',
      url: "/matches/6/game_boards/12/spacecraft_positions",
      data: JSON.stringify({matches_game_boards_spacecraft_form: {spacecraft_id: spacecraft, row: row, column: column}}),
      success: function(data) { 'success' },
      error: function(data) { alert('Posição invalida') },
      complete: function(data) { getImages() },
      contentType: "application/json",
      dataType: 'script'
    });
  }

  var matchId = $('#game-board-drop-bombs').attr('data-match-id')
  var gameBoardId = $('#game-board-drop-bombs').attr('data-game-board-id')

  $('td').click(function(event){
    let row = event.target.id.split('-')[0]
    let column = event.target.id.split('-')[1]

    $.ajax({
      type: 'POST',
      url: `/matches/${matchId}/game_boards/${gameBoardId}/drop_bombs`,
      data: JSON.stringify({matches_game_boards_drop_bomb_form: {row: row, column: column}}),
      success: function(data) { 'success' },
      error: function(data) { 'error' },
      complete: function(data) { 'complete' },
      contentType: "application/json",
      dataType: 'script'
    });
  });

  getImages()

  var myPlays = $('#my-plays').find('.check-my-plays');

  for(var i = 0; i < myPlays.length; i++){
    let droppedRow = $(myPlays[i]).attr('data-dropped-row');
    let droppedColumn = $(myPlays[i]).attr('data-dropped-column');

    let idCell = '#' + droppedRow + '-' + droppedColumn
    let offsetCell = $('#challenger-table').find(idCell).offset()
    
    $(myPlays[i]).offset(offsetCell)
  }

  var challengerPlays = $('#challenger-plays').find('.check-challenger-plays');

  for(var i = 0; i < challengerPlays.length; i++){
    let droppedRow = $(challengerPlays[i]).attr('data-dropped-row');
    let droppedColumn = $(challengerPlays[i]).attr('data-dropped-column');

    let idCell = '#' + droppedRow + '-' + droppedColumn
    let offsetCell = $('.spacecraft-distribution').find(idCell).offset()
    
    $(challengerPlays[i]).offset(offsetCell)
  }

  ;}, 200)
})

