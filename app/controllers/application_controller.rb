class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_logged_in?
  before_action :authentication

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    !current_user.nil?
  end

  def authentication
    redirect_to('/login') unless current_user
  end
end
