class Product < ActiveRecord::Base
  has_and_belongs_to_many :customer_orders

end
