class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("id DESC")
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new( order_params )
    @order.user = current_user
    @order.add_items(current_cart)

    if @order.save
      current_cart.destroy
      session[:cart_id] = nil

      redirect_to order_path(@order)
    else
      render "new"
    end
  end

  def show
    @order = current_user.orders.find( params[:id] )
  end

  protected

  def order_params
    params.require(:order).permit(:name, :phone, :address, :payment_method, :shipping_method)
  end

end
