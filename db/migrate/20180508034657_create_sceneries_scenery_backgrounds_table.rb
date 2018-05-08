class CreateSceneriesSceneryBackgroundsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sceneries_scenery_backgrounds, id: false do |t|
      t.belongs_to :scenery, index: true, foreign_key: true
      t.belongs_to :scenery_background, index: true, foreign_key: true
      t.index [:scenery_id, :scenery_background_id],
              unique: true,
              name: 'ux_sceneries_scenery_backgrounds'
    end
  end
end
