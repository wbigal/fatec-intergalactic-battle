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
    $('#game-board-drop-bombs').load data.render_url
