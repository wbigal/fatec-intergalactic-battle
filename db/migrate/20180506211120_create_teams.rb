class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, limit: 50, null: false
      t.timestamps
    end
  end
end
