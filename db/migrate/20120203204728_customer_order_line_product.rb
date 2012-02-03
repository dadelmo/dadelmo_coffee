class CustomerOrderLineProduct < ActiveRecord::Migration
  def self.up
    create_table :customer_order_line_products do |t|
      t.integer :customer_order_id
      t.integer :product_id
      t.integer :qty
      t.integer :price_per_item_in_cents

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_order_line_product
  end
end
