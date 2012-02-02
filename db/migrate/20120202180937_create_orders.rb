class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.date :order_date
      t.date :delivery_date
      t.integer :total_in_cents
      t.string :status, :default => :open

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
