class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.belongs_to :player, null: false, foreign_key: true
      t.integer :player_team_id, null: false
      t.integer :challenger_id, null: true
      t.integer :challenger_team_id, null: false
      t.belongs_to :scenery, null: false, foreign_key: true
      t.integer :winner_id, null: true
      t.datetime :started_at, null: true
      t.datetime :ended_at, null: true
      t.integer :total_time_in_seconds, null: true
      t.timestamps
      t.foreign_key :players, column: :challenger_id
      t.foreign_key :teams, column: :player_team_id
      t.foreign_key :teams, column: :challenger_team_id
      t.foreign_key :players, column: :winner_id
    end
  end
end
