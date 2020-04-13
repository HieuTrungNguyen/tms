class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: 404, status: false
  end

  def authenticate_user!
    return if logged_in?
    flash[:danger] = "You must log in first!"
    redirect_to login_path
  end

  def authenticate_supervisor!
    return if current_user.is_supervisor?
    flash[:danger] = "Permission role!"
    redirect_to root_path
  end
end
