class CustomerOrdersController < ApplicationController
  # GET /customer_orders
  # GET /customer_orders.xml
  def index
    @customer_orders = CustomerOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customer_orders }
    end
  end

  # GET /customer_orders/1
  # GET /customer_orders/1.xml
  def show
    @customer_order = CustomerOrder.find(params[:id])
    @total = @customer_order.customer_order_line_products.map(&:price_per_item_in_cents).sum

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer_order }
    end
  end

  # GET /customer_orders/new
  # GET /customer_orders/new.xml
  def new
    @customer_order = CustomerOrder.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer_order }
    end
  end

  # GET /customer_orders/1/edit
  def edit
    @customer_order = CustomerOrder.find(params[:id])
    @products = Product.where(:active => true).sort{|p, a| p.display_name <=> a.display_name }
    @total = @customer_order.customer_order_line_products.map(&:price_per_item_in_cents).sum
  end

  # POST /customer_orders
  # POST /customer_orders.xml
  def create
    @customer_order = CustomerOrder.new(params[:customer_order])
    @customer_order.user = signed_in_user
    respond_to do |format|
      if @customer_order.save
        format.html { redirect_to :action => 'edit', :id => @customer_order.id, :notice => 'Customer order was successfully created.' }
        format.xml  { render :xml => @customer_order, :status => :created, :location => @customer_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customer_orders/1
  # PUT /customer_orders/1.xml
  def update
    @customer_order = CustomerOrder.find(params[:id])

    respond_to do |format|
      if @customer_order.update_attributes(params[:customer_order])
        format.html { redirect_to(@customer_order, :notice => 'Customer order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer_order.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def add_item
    if params[:p_qty].blank?
      redirect_to edit_customer_order_path(CustomerOrder.find params[:customer_order][:id])  
      return 
    end    
    if params[:p_qty].to_i.nil?
      redirect_to edit_customer_order_path(CustomerOrder.find params[:customer_order][:id])  
      return 
    end    
    product = Product.find(params[:p_id])
    cid = params[:customer_order][:id]
    pid = params[:p_id]
    pqty = params[:p_qty]
    price = product.price_in_cents
    colp = CustomerOrderLineProduct.where(:customer_order_id => cid, :product_id => pid).first
    if colp.nil?
      colp = CustomerOrderLineProduct.new ({
        :customer_order_id => cid,
        :product_id => pid,
        :qty => pqty,
        :price_per_item_in_cents => price*pqty.to_i
      })
    else
      colp.qty = colp.qty + pqty.to_i
      colp.price_per_item_in_cents = colp.product.price_in_cents * colp.qty
    end
    colp.save!
    
    redirect_to edit_customer_order_path(CustomerOrder.find params[:customer_order][:id]) 
  end

  def delete_item
    cid = params[:customer_order][:id]
    pid =  params[:customer_order][:p_id]
    colp = CustomerOrderLineProduct.where(:customer_order_id => cid, :product_id => pid).first
    colp.destroy unless colp.nil? 
    redirect_to edit_customer_order_path(CustomerOrder.find params[:customer_order][:id]) 
  end


  # DELETE /customer_orders/1
  # DELETE /customer_orders/1.xml
  def destroy
    @customer_order = CustomerOrder.find(params[:id])
    @customer_order.destroy

    respond_to do |format|
      format.html { redirect_to(customer_orders_url) }
      format.xml  { head :ok }
    end
  end
end
