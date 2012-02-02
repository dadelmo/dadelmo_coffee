class User < ActiveRecord::Base
  has_many :customer_orders
end
