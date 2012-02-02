class Order < ActiveRecord::Base
  has_many :customer_orders
  
  validates_inclusion_of :status, :in => %w(open ordered shipped)

  
end
