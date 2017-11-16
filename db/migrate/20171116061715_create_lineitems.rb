class CreateLineitems < ActiveRecord::Migration
  def change
    create_table :lineitems do |t|
      t.integer :product_id, null: false
      t.integer :order_id, null: false

      t.timestamps null: false
    end
    add_index :lineitems, :product_id
    add_index :lineitems, :order_id
  end
end
