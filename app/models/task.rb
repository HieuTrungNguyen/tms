class Task < ApplicationRecord
  has_many :user_tasks, dependent: :destroy

  belongs_to :subject

  validates :name, presence: true, length: {maximum: Settings.max_text_length}
  validates :description, presence: true, length: {maximum: Settings.max_text_length}
end
