class AccountController < ApplicationController
  def show
    @user = signed_in_user

    @open_customer_order = nil
    @open_order = nil

    @customer_orders = @user.customer_orders
    @products = Product.all

    @customer_orders.each do |co|
      @open_customer_order = co if !co.order.nil? && co.order.status == 'open'
    end

    @open_order = Order.first(:conditions => {:status => :open}) if @open_customer_order.nil?
    @prev_orders = Order.all(:conditions => {:status => :open}) if @open_customer_order.nil?
    
  end

end
