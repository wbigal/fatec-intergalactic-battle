class CreateGameBoardsSpacecraftPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :game_boards_spacecraft_positions do |t|
      t.belongs_to :game_board, foreign_key: true, null: false
      t.belongs_to :spacecraft, foreign_key: true, null: false
      t.integer :row, null: false
      t.integer :column, null: false
      t.boolean :targeted, null: false, default: false
      t.timestamps

      t.index [:game_board_id, :spacecraft_id],
        unique: true,
        name: 'ix_gb_spacecraft_positions_on_game_board_and_spacecraft'

      t.index [:game_board_id, :row, :column],
        unique: true,
        name: 'ix_gb_spacecraft_positions_on_game_board_and_row_and_column'
    end
  end
end
