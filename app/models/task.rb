class Task < ApplicationRecord
  has_many :user_tasks, dependent: :destroy

  belongs_to :subject
end
