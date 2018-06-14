$(document).ready(function(){

  var background = '';
  var position = '';

  var insertBackground = function(url){
    if (background != '') 
      background += ','

    return background += 'url(' + url + ')'
  }

  var insertPosition = function(row, column){
    let positionY = 50 * (row - 1)
    let positionX = 50 * (column - 1)
    
    if (position != '')
      position += ','

    return position += positionX + 'px ' + positionY + 'px' 
  }

  var setPosition = function(url_image, row, column){
    table = $('table')
    table.css('background-image', insertBackground(url_image))
    table.css('background-position', insertPosition(row, column))
  }

  var limit = gon.spacecraft.length

  for (var i = 0; i < limit; i++ ){

    var spaceId = gon.spacecraft[i]
    var positions = gon.positions[i]
    var url = gon.url[i]

    setPosition(url, positions[0], positions[1])
  }

})