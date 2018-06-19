App.matches/playing = App.cable.subscriptions.create {
  channel: "Matches::PlayingChannel",
  match_id: $('#game-board-drop-bombs').attr('data-match-id'),
  game_board_id: $('#game-board-drop-bombs').attr('data-game-board-id')
},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#game-board-drop-bombs').load data.render_url, ->
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
