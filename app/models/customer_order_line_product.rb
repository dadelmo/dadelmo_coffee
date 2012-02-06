class CustomerOrderLineProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer_order
  
  validates_numericality_of :qty
  
end