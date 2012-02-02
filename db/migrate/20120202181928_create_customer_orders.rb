class CreateCustomerOrders < ActiveRecord::Migration
  def self.up
    create_table :customer_orders do |t|
      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_orders
  end
end
