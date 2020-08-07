class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  scope :get_subjects_in_course, ->(course_id) do
    joins(:subject).select("subjects.*").where(course_id: course_id)
  end
end
