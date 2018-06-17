# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  game_board_element = $('#game-board');
  match_id = game_board_element.data 'match-id'
  game_board_id = game_board_element.data 'game-board-id'
  $('#game-board-positions').load "/matches/#{match_id}/game_boards/#{game_board_id}/spacecraft_positions/new"
  return
