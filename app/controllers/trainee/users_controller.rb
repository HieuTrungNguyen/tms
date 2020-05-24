class Trainee::UsersController < Trainee::BasicApplicationController
  before_action :load_user

  def show; end

  def show_profile
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.users.update_success"
    else
      flash[:danger] = t "try_again"
    end
    redirect_to [:trainee, @user]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone_number, :address, :avatar, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end

  def correct_user

  end
end
