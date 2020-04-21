module UsersHelper
  def get_role_user user
    User.roles.keys[user.role]
  end
end
