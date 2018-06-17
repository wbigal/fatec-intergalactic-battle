$(document).ready(function(){

  var sizeCell = 50
  var adjust = 8

  var setPosition = function(parent, elem){
    $(parent).css({position: 'relative'})
    $(elem).css({position: 'absolute'})

    var dataRow = parseInt($(elem).attr('data-row'))
    var dataColumn = parseInt($(elem).attr('data-column'))

    var idCell = '#' + dataRow + '-' + dataColumn

    var topCell = $(idCell).offset().top - sizeCell - adjust
    var leftCell = $(idCell).offset().left

    $(elem).css({left: leftCell, top: topCell})
  }

  var getImages = function(){
    var spacecrafts = $('.spacecraft-collection').find('img')
    for(var i = 0; i < spacecrafts.length; i++){
      setPosition($('body'), spacecrafts[i])
    }
  }

  $('td').click(function(event){
    let spacecraft = $('input:checked').val()
    if(spacecraft){
      var id = event.target.id.split('-')
  
      $.ajax({
        type: 'POST',
        url: '/matches/2/game_boards/3/spacecraft_positions',
        data: JSON.stringify({matches_game_boards_spacecraft_form: {spacecraft_id: spacecraft, row: id[0], column: id[1]}}),
        success: function(data) { },
        complete: function(data) { getImages() },
        contentType: "application/json",
        dataType: 'script'
      });
    }
  });

  getImages();
})