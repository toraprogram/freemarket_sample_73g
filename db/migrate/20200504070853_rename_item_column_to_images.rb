class RenameItemColumnToImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :item, :item_id
  end
end
