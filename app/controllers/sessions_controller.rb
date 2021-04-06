class SessionsController < ApplicationController
  skip_before_action :authentication, only: %i[new create]
  def new; end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to(root_path)
    else
      redirect_to('/login', notice: 'Неверный логин или пароль')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to('/login')
  end

  private

  def user_params
    params.require('/login').permit(:email, :password)
  end
end
