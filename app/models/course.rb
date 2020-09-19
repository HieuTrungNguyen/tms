class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy

  has_many :subjects, through: :course_subjects, dependent: :destroy
  has_many :users, through: :user_courses, dependent: :destroy

  after_destroy {time_training_of_course}

  mount_uploader :cover, CourseCoverUploader

  validates :name, presence: true, length: {maximum: Settings.max_text_length},
    uniqueness: {case_sensitive: false}
  validates :description, presence: true
  validates :time_training, presence: true

  scope :order_desc, ->{order created_at: :desc}

  def time_training_of_course
    self.time_training = 0
    self.subjects.each{ |subject| self.time_training += subject.time_training}
    return self.time_training
  end
end
