$(document).ready(function(){

setTimeout(function(){  
  var sizeCell = 0
  var adjust = 0
  var oldElem;
  var elem;

  var match = $('#spacecraft-position-form').attr('data-match-id')
  var gameBoard = $('#spacecraft-position-form').attr('data-game-board-id')

  var imgDraggable = $('.spacecraft-for-position').find('img') 

  for(var i = 0; i < imgDraggable.length; i++){
    $( imgDraggable[i] ).draggable({
      cursorAt: { left: 0, top: 0 },
      revert: true,
      revertDuration: 1,
      stop: function( event, ui ) { 
        if(elem){ 
          createPosition(event.target.id, 
                         $(elem).attr('id').split('-')[0], 
                         $(elem).attr('id').split('-')[1])
        } 
      },
      drag: function( event, ui ) {
        $("td").mousemove( function(e) {
          client_x = e.pageX;
          client_y = e.pageY;
          elem = document.elementFromPoint(client_x, client_y - $(window).scrollTop())
          if(elem != oldElem){
            $(oldElem).css({background: ''})  
            $(elem).css({background: 'gray'})
          }

          oldElem = elem
        });
      }      
    });
  }

  var setPosition = function(parent, elem){
    $(parent).css({position: 'relative'})
    $(elem).css({position: 'absolute'})

    var dataRow = parseInt($(elem).attr('data-row'))
    var dataColumn = parseInt($(elem).attr('data-column'))

    var idCell = '#' + dataRow + '-' + dataColumn

    var topCell = $(idCell).offset().top - sizeCell
    var leftCell = $(idCell).offset().left - sizeCell

    $(elem).offset({left: leftCell, top: topCell})
  }

  var getImages = function(){
    var spacecrafts = $('.spacecraft-collection').find('img')
    for(var i = 0; i < spacecrafts.length; i++){
      setPosition($('body'), spacecrafts[i])
    }
  }

  var createPosition = function(spacecraft, row, column){
    $.ajax({
      type: 'POST',
      url: `/matches/${match}/game_boards/${gameBoard}/spacecraft_positions`,
      data: JSON.stringify({matches_game_boards_spacecraft_form: {spacecraft_id: spacecraft, row: row, column: column}}),
      success: function(data) { 'success' },
      error: function(data) { alert('Posição invalida') },
      complete: function(data) { getImages() },
      contentType: "application/json",
      dataType: 'script'
    });
  }

  getImages();
  
  }, 200)
})