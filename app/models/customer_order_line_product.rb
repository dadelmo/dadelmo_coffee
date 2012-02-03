class CustomerOrderLineProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer_order
end