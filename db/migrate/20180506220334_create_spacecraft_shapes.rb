class CreateSpacecraftShapes < ActiveRecord::Migration[5.2]
  def change
    create_table :spacecraft_shapes do |t|
      t.string :name, limit: 50, null: false
      t.attachment :template
      t.json :targets, null: false
      t.integer :spacecraft_width, null: false
      t.integer :spacecraft_height, null: false
      t.timestamps
    end
  end
end
