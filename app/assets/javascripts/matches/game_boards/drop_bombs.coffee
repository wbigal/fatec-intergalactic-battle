$(document).ready ->
  game_board_element = $('#game-board-drop-bombs');
  match_id = game_board_element.data 'match-id'
  game_board_id = game_board_element.data 'game-board-id'

  sizeCell = 50
  adjust = 0
  oldElem = undefined
  elem = undefined
  imgDraggable = $('.spacecraft-distribution').find('img')

  findWinner = ->
    if($('#drop-bomb-form strong').text() == 'voce ganhou')
      $('#winner').modal();
    else if($('#drop-bomb-form strong').text() == 'voce perdeu')
      $('#lose').modal();

  setPosition = (parent, elem) ->
    dataRow = parseInt($(elem).attr('data-row'))
    dataColumn = parseInt($(elem).attr('data-column'))
    idCell = '#' + dataRow + '-' + dataColumn
    offsetCell = $(idCell).offset()
    $(elem).offset offsetCell
    return

  getImages = ->
    spacecrafts = $('.spacecraft-distribution').find('img')
    i = 0
    while i < spacecrafts.length
      setPosition $('.spacecraft-distribution'), spacecrafts[i]
      i++
    return

  createPosition = (spacecraft, row, column) ->
    $.ajax
      type: 'POST'
      url: '/matches/' + match_id + '/game_boards/' + game_board_id + '/spacecraft_positions'
      data: JSON.stringify(matches_game_boards_spacecraft_form:
        spacecraft_id: spacecraft
        row: row
        column: column)
      success: (data) ->
        console.log('success position')
        return
      error: (data) ->
        alert 'Posição invalida'
        return
      complete: (data) ->
        console.log('complete')
        return
      contentType: 'application/json'
      dataType: 'script'
    return

  setChecks = ->
    console.log 1
    myPlays = $('#my-plays').find('img')

    i = 0
    while i < myPlays.length
      droppedRow = $(myPlays[i]).attr('data-dropped-row')
      droppedColumn = $(myPlays[i]).attr('data-dropped-column')
      idCell = '#' + droppedRow + '-' + droppedColumn
      offsetCell = $('#challenger-table').find(idCell).offset()
      $(myPlays[i]).offset offsetCell
      i++

    challengerPlays = $('#challenger-plays').find('img')

    i = 0
    while i < challengerPlays.length
      droppedRow = $(challengerPlays[i]).attr('data-dropped-row')
      droppedColumn = $(challengerPlays[i]).attr('data-dropped-column')
      idCell = '#' + droppedRow + '-' + droppedColumn
      offsetCell = $('.spacecraft-distribution').find(idCell).offset()
      $(challengerPlays[i]).offset offsetCell
      i++

  $('td').click (event) ->
    row = event.target.id.split('-')[0]
    column = event.target.id.split('-')[1]
    $.ajax
      type: 'POST'
      url: '/matches/' + match_id + '/game_boards/' + game_board_id + '/drop_bombs'
      data: JSON.stringify(matches_game_boards_drop_bomb_form:
        row: row
        column: column)
      success: (data) ->
        setChecks()
        findWinner()
        return
      error: (data) ->
        alert 'Invalido'
        return
      complete: (data) ->
        console.log('complete')
        return
      contentType: 'application/json'
      dataType: 'script'
    return

  game_board_element.load "/matches/#{match_id}/game_boards/#{game_board_id}/drop_bombs/new", ->
    $('.background').css 'background-image', 'url(' + $('.background').attr('data-url') + ')'
    getImages()
    setChecks()
  return
