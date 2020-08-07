class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i(new create)
  before_action :authenticate_supervisor!, only: %i(index destroy)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(show edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.users.created_success"
      log_in @user
      user.supervisor? ? redirect_to(@user) : redirect_to([:trainee, @user])
    else
      flash[:danger] = t "flash.users.created_fail"
      render :new
    end
  end

  def index
    @users = User.page(params[:page]).per Settings.user.default_per_page
  end

  def show_profile
    respond_to do |format|
      format.js
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.users.update_success"
    else
      flash[:danger] = t "try_again"
    end
    redirect_to @user
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.users.delete_success"
    else
      flash[:danger] = t "try_again"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone_number, :address, :avatar, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end

  def correct_user
    redirect_to root_path unless current_user.supervisor? || current_user?(@user)
  end
end
