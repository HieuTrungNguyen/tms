class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum status: {active: 0, close: 1}

  scope :get_users_in_course_with_role, ->(course_id, role) do
    UserCourse.get_users_in_course(course_id).merge(role)
  end
  scope :get_users_in_course, ->(course_id) do
    joins(:user).select("users.*, user_courses.status")
                .where(course_id: course_id)
  end
  scope :get_users_id_in_course, ->(course_id) do
    joins(:user).select("users.id").where(course_id: course_id)
  end
end
