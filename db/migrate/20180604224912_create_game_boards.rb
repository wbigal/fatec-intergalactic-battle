class CreateGameBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :game_boards do |t|
      t.belongs_to :player, foreign_key: true, null: false
      t.belongs_to :match, foreign_key: true, null: false
      t.belongs_to :scenery_background, foreign_key: true, null: false
      t.boolean :ready_to_play, null: false, default: false
      t.integer :rows, null: false
      t.integer :columns, null: false
      t.timestamps
      t.index [:player_id, :match_id], unique: true
    end
  end
end
