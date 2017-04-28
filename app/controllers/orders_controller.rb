class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("id DESC")
  end

  def new
    if current_cart.cart_items.empty?
      flash[:alert] = "沒東西幹嘛結帳!!"
      redirect_to root_path
    end

    @order = Order.new
  end

  def create
    @order = Order.new( order_params )
    @order.user = current_user
    @order.add_items(current_cart)

    if @order.save
      UserMailer.notify_order(@order).deliver_later

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

  def checkout_pay2go
    @order = current_user.orders.find( params[:id] )

    if @order.paid?
      flash[:alert] = "你已經付過啦"
      redirecto_to order_path(@order)
    else
      @payment = Payment.create!( :order => @order,
                                  :payment_method => params[:payment_method],
                                  :amount => @order.amount )
      render :layout => false
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :phone, :address, :payment_method, :shipping_method)
  end

end
