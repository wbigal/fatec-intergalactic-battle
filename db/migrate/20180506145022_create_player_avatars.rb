class CreatePlayerAvatars < ActiveRecord::Migration[5.2]
  def change
    create_table :player_avatars do |t|
      t.string :name, limit: 50, null: false
      t.attachment :image
      t.timestamps
    end
  end
end
