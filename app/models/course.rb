class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  scope :order_desc, ->{order created_at: :desc}

  mount_uploader :cover, CourseCoverUploader

  validates :name, presence: true, length: {maximum: Settings.max_text_length},
    uniqueness: {case_sensitive: false}
  validates :description, presence: true
  validates :time_training, presence: true
end
