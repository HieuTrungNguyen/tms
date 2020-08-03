class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  scope :get_users_on_course_with_role, ->(course_id, role) do
    joins(:user).select("users.*, user_courses.status")
                .where(course_id: course_id).merge(role)
  end
end
