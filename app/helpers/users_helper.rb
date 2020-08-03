module UsersHelper
  def get_role_user user
    User.roles[user.role]
  end
end
