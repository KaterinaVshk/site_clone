class UsersController < ApplicationController
  skip_before_action :authentication, only: %i[new create]
  before_action :check_admin, only: %i[index make_admin cancel_admin_rights]
  before_action :set_user, only: %i[show edit update make_admin cancel_admin_rights]
  def index
    @users = User.paginate(page: params[:page], per_page: User::PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
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

  def show; end

  def edit
    redirect_to(user_path(@user)) unless current_user == @user
  end

  def update
    if @user.update(update_user_params)
      flash[:notice] = 'Профиль успешно обновлен'
      redirect_to(user_path(@user))
    else
      flash[:alert] = 'Не удалось обновить профиль'
      render('edit')
    end
  end

  def make_admin
    if @user.update(type: 'Admin')
      flash[:notice] = 'Успешно добавлен новый администратор'
    else
      flash[:alert] = 'Что-то пошло не так, попробуйте ещё раз'
    end
    redirect_to(action: 'index')
  end

  def cancel_admin_rights
    if @user.update(type: 'User')
      flash[:notice] = 'Администратор успешно удален'
    else
      flash[:alert] = 'Что-то пошло не так, попробуйте ещё раз'
    end
    redirect_to(action: 'index')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_user_params
    return params.require(:user).permit(:nickname, :first_name, :last_name, :birthday, :city, :photo) if @user.type == 'User'
    return params.require(:admin).permit(:nickname, :first_name, :last_name, :birthday, :city, :photo) if @user.type == 'Admin'
  end
end
