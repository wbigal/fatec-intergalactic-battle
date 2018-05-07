class RemoveImageFieldFromSceneries < ActiveRecord::Migration[5.2]
  def change
    remove_column :sceneries, :image_file_name
    remove_column :sceneries, :image_content_type
    remove_column :sceneries, :image_file_size
    remove_column :sceneries, :image_updated_at
  end
end
