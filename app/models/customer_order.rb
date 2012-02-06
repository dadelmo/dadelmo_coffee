class CustomerOrder < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => [:order_id]
  has_many :customer_order_line_products
  belongs_to :user
  belongs_to :order
end
