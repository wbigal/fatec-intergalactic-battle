# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#game-board-positions').load '/matches/5/game_boards/8/spacecraft_positions/new'
  return
