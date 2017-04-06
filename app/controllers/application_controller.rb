class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart

  before_action :set_locale

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def current_cart
    return @cart if @cart

    if session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
      return @cart if @cart
    end

    @cart = Cart.create
    session[:cart_id] = @cart.id

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
