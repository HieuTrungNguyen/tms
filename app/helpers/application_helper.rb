module ApplicationHelper
  def set_avatar user
    if user.nil?
      "userpicture.png"
    elsif user.avatar?
      user.avatar
    else
      Settings.user.default_avatar
    end
  end

  def format_date datetime
    datetime.strftime "%B %d, %Y"
  end
end
