class ChangeDatatypeOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :delivery_method, true
    change_column_null :items, :buyer_id, true
    change_column_null :items, :shipping_method, true

    rename_column :items, :brand_id, :brand
    change_column_null :items, :brand, true
  end
end