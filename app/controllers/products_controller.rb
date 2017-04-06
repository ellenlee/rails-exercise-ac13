class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find( params[:id] )

    current_cart.add_product(@product)

    #redirect_to root_path

  end

  def remove
    @product = Product.find(params[:id])

    existing_item = current_cart.cart_items.where( :product_id => @product.id ).first
    existing_item.destroy

    redirect_to :back
  end

end
