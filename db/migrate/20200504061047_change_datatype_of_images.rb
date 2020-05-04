class ChangeDatatypeOfImages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :images, :item_id, false
  end
end