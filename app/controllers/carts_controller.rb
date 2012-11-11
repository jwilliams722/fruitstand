class CartsController < ApplicationController

  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.json { render :json => @products }
    end
  end

  def create
    @cart = Cart.create

    redirect_to cart_path(@cart) #@cart is passing the current cart to the view
  end

  def show
    @cart = Cart.find(session[:id])
    @products = Product.all

    respond_to do |format|
      format.html
      format.json { render :json => @products }
    end
  end

  def add_to_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    product = Product.find(params[:product_id]) #passing a product id to the product variable

    if @line_item = @cart.line_items.find_by_product_id(product)

        if @line_item.quantity.nil?
          @line_item.quantity = 1
        else
          @line_item.quantity += 1
        end
    else
      @line_item = @cart.line_items.new(:product => product, :quantity => 1)
    end
    if @line_item.save
      flash[:notice] = "Item saved successfully"
    else
      flash[:error] = "There was a problem adding item to cart"
    end
    redirect_to cart_path(@cart)

  end

  def delete_from_cart
    @line_item = LineItem.find(params[:line_item_id])
    @cart = Cart.find(session[:id])
    if @line_item.destroy
      flash[:notice] = "Item Deleted Successfully"

    else
      flash[:error] = "Item could not be deleted"
    end
    redirect_to cart_path(@cart)
  end

  def checkout
    @cart = Cart.find(session[:id]) #create a before method
    @order - Order.create
    @cart.line_items.each do |line_item|
      @order.line_items << LineItem.new({product: line_item.product, quantity: line_item.quantity})
    end
    @order.save
    if @order.bill
      session[:cart_id] = nil
      @cart.destroy
      flash[:notice] = "Thank you for completing your order"
      redirect_to root_path
    end
  end

  #def find_cart
  #  @cart = Cart.find(session[:cart_id])
  #end
end