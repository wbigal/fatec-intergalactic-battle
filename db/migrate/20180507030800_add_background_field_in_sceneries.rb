class AddBackgroundFieldInSceneries < ActiveRecord::Migration[5.2]
  def change
    add_reference :sceneries, :scenery_background,
                              index: true,
                              foreign_key: true
  end
end
