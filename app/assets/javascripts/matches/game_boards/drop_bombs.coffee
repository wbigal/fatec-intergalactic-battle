$(document).ready ->
  game_board_element = $('#game-board-drop-bombs');
  match_id = game_board_element.data 'match-id'
  game_board_id = game_board_element.data 'game-board-id'
  game_board_element.load "/matches/#{match_id}/game_boards/#{game_board_id}/drop_bombs/new"
  return
