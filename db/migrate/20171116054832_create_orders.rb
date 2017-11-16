class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :status, null: false, default: 1

      t.timestamps null: false
    end
  end
end
