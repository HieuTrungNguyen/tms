class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i(new create)
  before_action :authenticate_supervisor!, only: :index
  before_action :load_user, except: %i(new create index)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".created_success"
      log_in @user
      redirect_to @user
    else
      flash[:danger] = t ".created_fail"
      render :new
    end
  end

  def show_profile
    @user = User.find_by id: params[:id]
    respond_to do |format|
      format.js
    end
  end

  def show; end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone_number, :address
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end
end
