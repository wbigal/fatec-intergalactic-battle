class CreateGameBoardsDroppedBombs < ActiveRecord::Migration[5.2]
  def change
    create_table :game_boards_dropped_bombs do |t|
      t.belongs_to :game_board, foreign_key: true, null: false
      t.belongs_to :game_boards_spacecraft_position,
                   foreign_key: true,
                   null: true,
                   index: {
                     name: 'ix_gb_dropped_bombs_on_gb_spacecraft_position_id'
                   }
      t.integer :row, null: false
      t.integer :column, null: false
      t.timestamps

      t.index [:game_board_id, :game_boards_spacecraft_position_id],
        unique: true,
        name: 'uix_gb_dropped_bombs_on_gb_spacecraft_position_id'

      t.index [:game_board_id, :row, :column],
        unique: true,
        name: 'ix_gb_dropped_bombs_on_game_board_and_row_and_column'
    end
  end
end
