class ProductsController < ApplicationController

  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.json { render :json => @products }
    end
  end

  #def new
  #end
  #
  #def update
  #end
end
