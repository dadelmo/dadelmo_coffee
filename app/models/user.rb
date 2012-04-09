class User < ActiveRecord::Base
  has_many :customer_orders
  belongs_to :role
end
