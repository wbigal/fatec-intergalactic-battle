class CreateSceneryBackgrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :scenery_backgrounds do |t|
      t.string :name, limit: 50, null: false
      t.attachment :image
      t.timestamps
      t.index :name, unique: true
      t.timestamps
    end
  end
end
