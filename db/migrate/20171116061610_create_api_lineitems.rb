class CreateApiLineitems < ActiveRecord::Migration
  def change
    create_table :api_lineitems do |t|
      t.integer :product_id
      t.integer :order_id

      t.timestamps null: false
    end
    add_index :users, :username, unique: true
  end
end
