class CreateSceneriesSpacecraftsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sceneries_spacecrafts, id: false do |t|
      t.belongs_to :scenery, index: true, foreign_key: true
      t.belongs_to :spacecraft, index: true, foreign_key: true
      t.index [:scenery_id, :spacecraft_id], unique: true
    end
  end
end
