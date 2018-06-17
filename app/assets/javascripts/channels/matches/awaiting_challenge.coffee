App.matches/awaiting_challenge = App.cable.subscriptions.create {
  channel: "Matches::AwaitingChallengeChannel",
  match_id: $('#match-details').data 'match-id'
},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    alert(data.json['message'])
    window.location = data.json['redirect_to']
