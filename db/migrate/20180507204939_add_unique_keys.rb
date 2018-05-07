class AddUniqueKeys < ActiveRecord::Migration[5.2]
  def change
    add_index :player_avatars, :name, unique: true
    add_index :players, :nickname, unique: true
    add_index :sceneries, :name, unique: true
    add_index :spacecraft_shapes, :name, unique: true
    add_index :teams, :name, unique: true
  end
end
