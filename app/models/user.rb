class User < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :user_tasks, dependent: :destroy

  before_save {email.downcase!}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/i

  validates :name, presence: true, length: {maximum: Settings.users.max_text_length}
  validates :email, presence: true, length: {maximum: Settings.users.max_text_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, :password_confirmation, presence: true,
    length: {minimum: Settings.users.min_pass_length,
    maximum: Settings.users.max_text_length}
  validates :phone_number, presence: true,
    length: {minimum: Settings.users.min_phone_number_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true, length: {maximum: Settings.users.max_text_length}
end
