class CreateSceneries < ActiveRecord::Migration[5.2]
  def change
    create_table :sceneries do |t|
      t.string :name, limit: 50, null: false
      t.integer :rows, null: false
      t.integer :columns, null: false
      t.attachment :image
      t.timestamps
    end
  end
end
