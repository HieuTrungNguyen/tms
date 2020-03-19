class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".created_success"
      redirect_to @user
    else
      flash[:danger] = t ".created_fail"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone_number, :address
  end
end
