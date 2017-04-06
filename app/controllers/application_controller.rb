class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart

  def current_cart
    return @cart if @cart

    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    
    return @cart
  end

  def check_admin!
    if current_user && current_user.is_admin?
      # ok
    else
      flash[:alert] = "你沒權限"
      redirect_to root_path
    end
  end

end
