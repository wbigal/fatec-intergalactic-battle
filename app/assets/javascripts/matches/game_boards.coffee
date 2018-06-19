# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  game_board_element = $('#game-board');
  match_id = game_board_element.data 'match-id'
  game_board_id = game_board_element.data 'game-board-id'

  setPosition = (parent, elem) ->
    $(parent).css position: 'relative'
    $(elem).css position: 'absolute'
    dataRow = parseInt($(elem).attr('data-row'))
    dataColumn = parseInt($(elem).attr('data-column'))
    idCell = '#' + dataRow + '-' + dataColumn
    topCell = $(idCell).offset().top
    leftCell = $(idCell).offset().left
    $(elem).offset
      left: leftCell
      top: topCell
    return
  
  deleteSpace = (row, column) ->
    $.ajax
      type: 'delete'
      url: '/matches/' + match_id + '/game_boards/' + game_board_id + '/spacecraft_positions/position/row/' + row + '/column/' + column
      contentType: 'application/json'
      dataType: 'script'
    return

  getImages = ->
    spacecrafts = $('.spacecraft-collection').find('img')
    i = 0
    while i < spacecrafts.length
      setPosition $('body'), spacecrafts[i]
      i++
    return
    
  createPosition = (spacecraft, row, column) ->
    $.ajax
      type: 'POST'
      url: '/matches/' + match_id + '/game_boards/' + game_board_id + '/spacecraft_positions',
      data: JSON.stringify(matches_game_boards_spacecraft_form:
        spacecraft_id: spacecraft
        row: row
        column: column)
      success: (data) ->
        getImages()
        setDraggable()
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

  setDraggable = ->
    oldElem = undefined
    elem = undefined
    imgDraggable = $('.spacecraft-for-position').find('img')
    i = 0
    while i < imgDraggable.length
      $(imgDraggable[i]).draggable
        cursorAt:
          left: 0
          top: 0
        revert: true
        revertDuration: 1
        stop: (event, ui) ->
          if elem
            createPosition event.target.id, $(elem).attr('id').split('-')[0], $(elem).attr('id').split('-')[1]
          return
        drag: (event, ui) ->
          $('td').mousemove (e) ->
            client_x = e.pageX
            client_y = e.pageY
            elem = document.elementFromPoint(client_x, client_y - $(window).scrollTop())
            if elem != oldElem
              $(oldElem).css background: ''
              $(elem).css background: 'gray'
            oldElem = elem
            return
          return
      i++

  $('img').dblclick ->
    row = $(this).attr('data-row')
    column = $(this).attr('data-column')
    if confirm('Deletar? ')
      deleteSpace row, column
      window.location.reload()
      return
      
  $('#game-board-positions').load "/matches/#{match_id}/game_boards/#{game_board_id}/spacecraft_positions/new", ->
    getImages()
    setDraggable()
  return
