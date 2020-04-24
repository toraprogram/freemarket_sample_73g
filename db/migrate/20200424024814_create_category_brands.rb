class CreateCategoryBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :category_brands do |t|

      t.timestamps
    end
  end
end
