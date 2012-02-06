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
    @products = Product.all

  end

  # POST /customer_orders
  # POST /customer_orders.xml
  def create
    @customer_order = CustomerOrder.new(params[:customer_order])
    @customer_order.user = signed_in_user
    respond_to do |format|
      if @customer_order.save
        format.html { redirect_to(@customer_order, :notice => 'Customer order was successfully created.') }
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
    product = Product.find(params[:p_id])
    colp = CustomerOrderLineProduct.new (
      :customer_order_id => params[:customer_order][:id],
      :product_id => params[:p_id],
      :qty => params[:p_qty],
      :price_per_item_in_cents => product.price_in_cents
    )
    colp.save!
    
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
