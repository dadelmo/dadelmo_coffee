# encoding: UTF-8
class Product < ActiveRecord::Base
  has_and_belongs_to_many :customer_orders
  
  def display_name
    "#{name} #{price_in_cents.to_f/100}"
  end

end
