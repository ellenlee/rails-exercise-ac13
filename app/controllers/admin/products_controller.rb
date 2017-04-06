class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin!

  def index
    @products = Product.all
  end

end
