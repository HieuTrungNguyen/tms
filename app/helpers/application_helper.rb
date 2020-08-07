module ApplicationHelper
  def set_avatar user
    user.nil? ? Settings.user.user_picture :
      set_object_img(user.avatar, Settings.user.default_avatar)
  end

  def set_object_img object_img, default_img
    object_img.blank? ? default_img : object_img
  end

  def format_date datetime
    datetime.strftime "%B %d, %Y"
  end

  def show_profile_path user
    redirect_to root_path if user.nil?
    user.supervisor? ? show_profile_user_path(user)
                     : show_profile_trainee_user_path(user)
  end

  def show_path user
    redirect_to root_path if user.nil?
    user.supervisor? ? user : [:trainee, user]
  end

  def edit_path user
    redirect_to root_path if user.nil?
    user.supervisor? ? edit_user_path(user) : edit_trainee_user_path(user)
  end
end
