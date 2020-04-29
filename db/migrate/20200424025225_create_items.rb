class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer    :seller_id,        null: false,foreign_key: true
      t.string     :name,             null: false, unique: true, index:true
      t.references :category,         foreign_key: true
      t.references :brand,            foreign_key: true
      t.integer    :price,            null: false
      t.text       :description,      null: false
      t.string     :condition,        null: false
      t.string     :delivery_charge,  null: false
      t.string     :delivery_method
      t.integer    :prefecture_id,    null: false
      t.string     :delivery_day,     null: false
      t.string     :size,             null: false
      t.boolean    :state,            null: false, default: false
      t.integer    :buyer_id,         foreign_key: true
      t.string     :shipping_method

      t.timestamps
    end
  end
end
