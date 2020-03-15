class Subject < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
end
