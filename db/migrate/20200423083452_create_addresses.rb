class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user,  foreign_key: true
      t.string :postal_code, null: false
      t.string :prefecture,  null: false
      t.string :city,        null: false
      t.string :block
      t.string :building
      t.string :phone

      t.timestamps
    end
  end
end
