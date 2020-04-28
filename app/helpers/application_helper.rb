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
end
