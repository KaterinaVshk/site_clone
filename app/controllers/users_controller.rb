class UsersController < ApplicationController
  skip_before_action :authentication, only: %i[new create]
  before_action :check_admin, only: %i[index make_admin cancel_admin_rights]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(root_path)
    else
      render('new')
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def make_admin
    @user = User.find(params[:id])
    if @user.update(type: 'Admin')
      flash[:notice] = 'Успешно добавлен новый администратор'
    else
      flash[:alert] = 'Что-то пошло не так, попробуйте ещё раз'
    end
    redirect_to(action: 'index')
  end

  def cancel_admin_rights
    @user = User.find(params[:id])
    if @user.update(type: 'User')
      flash[:notice] = 'Администратор успешно удален'
    else
      flash[:alert] = 'Что-то пошло не так, попробуйте ещё раз'
    end
    redirect_to(action: 'index')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
