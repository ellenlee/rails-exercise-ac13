class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_admin!
    if current_user && current_user.is_admin?
      # ok
    else      
      flash[:alert] = "你沒權限"
      redirect_to root_path
    end
  end

end
