class Subject < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :course_subjects, dependent: :destroy

  mount_uploader :cover, SubjectCoverUploader

  scope :get_subjects_not_exist_in_course, ->(course_id) do
    where("id NOT IN (?)", CourseSubject.get_subjects_id_in_course(course_id))
  end
  scope :newest, ->{order created_at: :desc}
end
