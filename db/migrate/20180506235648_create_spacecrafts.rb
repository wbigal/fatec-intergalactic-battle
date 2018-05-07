class CreateSpacecrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :spacecrafts do |t|
      t.belongs_to :team, null: false, index: true, foreign_key: true
      t.belongs_to :spacecraft_shape, null: false,
                                      index: true,
                                      foreign_key: true
      t.string :name, limit: 50, null: false
      t.attachment :image
      t.timestamps
      t.index :name, unique: true
    end
  end
end
