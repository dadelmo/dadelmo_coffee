class DropCoPrNmRelation < ActiveRecord::Migration
  def self.up
     drop_table :customer_orders_products
  end

  def self.down
    create_table :customer_orders_products, :id => false do |t|
      t.integer :product_id
      t.integer :customer_order_id
    end
  end
end
