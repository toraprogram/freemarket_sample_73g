class CreateItemCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_categories do |t|
      t.references :item, null:false
      t.references :category, null:false

      t.timestamps
    end
  end
end
