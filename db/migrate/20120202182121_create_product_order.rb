class CreateProductOrder < ActiveRecord::Migration
  def self.up
    create_table :customer_orders_products, :id => false do |t|
      t.integer :product_id
      t.integer :customer_order_id
    end
  end

  def self.down
    drop_table :customer_orders_products 
  end
end
