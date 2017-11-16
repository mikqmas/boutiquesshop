class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null:false, default: "no name"
      t.string :description, default: "no description"
      t.decimal :price, null:false, default: 0.00
      t.integer :stock, default: 0

      t.timestamps null: false
    end
  end
end
