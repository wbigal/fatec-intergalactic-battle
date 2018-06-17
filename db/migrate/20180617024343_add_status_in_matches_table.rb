class AddStatusInMatchesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :status, :string, limit: 50,
                                           null: false,
                                           default: 'awaiting_challenge'
  end
end
