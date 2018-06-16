$(document).ready(function(){
  $('td').click(function(event){
    let spacecraft = $('input:checked').val()
    if(spacecraft){
      var id = event.target.id.split('-')
  
      $.ajax({
        type: 'POST',
        url: '/matches/25/game_boards/22/spacecraft_positions',
        data: JSON.stringify({matches_game_boards_spacecraft_form: {spacecraft_id: spacecraft, row: id[0], column: id[1]}}),
        success: function(data) {  },
        contentType: "application/json",
        dataType: 'script'
      });
    }
  });

  // var setPos = function(){
  //   alert('setPos');
  //   var sizeCell = 50;

  //   var background = '';
  //   var position = '';

  //   var insertBackground = function(url){
  //     if (background != '') 
  //       background += ','

  //     return background += 'url(' + url + ')'
  //   }

  //   var insertPosition = function(row, column){
  //     let positionY = sizeCell * (row - 1)
  //     let positionX = sizeCell * (column - 1)
      
  //     if (position != '')
  //       position += ','

  //     return position += positionX + 'px ' + positionY + 'px' 
  //   }

  //   var setPosition = function(url_image, row, column){
  //     table = $('table')
  //     table.css('background-image', insertBackground(url_image))
  //     table.css('background-position', insertPosition(row, column))
  //   }

  //   var limit = gon.spacecraft.length

  //   console.log(gon.spacecraft)

  //   for (var i = 0; i < limit; i++ ){

  //     var spaceId = gon.spacecraft[i]
  //     var positions = gon.positions[i]
  //     var url = gon.url[i]

  //     alert(spaceId)
  //     setPosition(url, positions[0], positions[1])
  //   }

  // };
})