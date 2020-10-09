class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy

  has_many :subjects, through: :course_subjects, dependent: :destroy
  has_many :users, through: :user_courses, dependent: :destroy

  mount_uploader :cover, CourseCoverUploader

  validates :name, presence: true, length: {maximum: Settings.max_text_length},
    uniqueness: {case_sensitive: false}
  validates :description, presence: true
  validates :time_training, presence: true

  scope :order_desc, ->{order created_at: :desc}

  def time_training_of_course
    time_training = 0
    self.subjects.each{ |subject| time_training += subject.time_training}
    update_attributes time_training: time_training
  end
end
