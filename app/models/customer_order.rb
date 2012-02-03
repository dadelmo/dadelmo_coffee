class CustomerOrder < ActiveRecord::Base
  has_many :customer_order_line_products
  belongs_to :user
  belongs_to :order
end
