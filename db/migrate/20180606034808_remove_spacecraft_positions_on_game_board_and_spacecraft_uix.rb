class RemoveSpacecraftPositionsOnGameBoardAndSpacecraftUix < ActiveRecord::Migration[5.2]
  def change
    remove_index :game_boards_spacecraft_positions,
                 name: 'ix_gb_spacecraft_positions_on_game_board_and_spacecraft'
  end
end
