class User < ApplicationRecord
  attr_reader :remember_token

  has_many :user_courses, dependent: :destroy
  has_many :user_tasks, dependent: :destroy

  before_save {email.downcase!}

  mount_uploader :avatar, AvatarUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/i

  validates :name, presence: true, length: {maximum: Settings.max_text_length}
  validates :email, presence: true, length: {maximum: Settings.max_text_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, :password_confirmation, presence: true,
    length: {minimum: Settings.user.min_pass_length,
    maximum: Settings.max_text_length}
  validates :phone_number, presence: true,
    length: {minimum: Settings.user.min_phone_number_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true, length: {maximum: Settings.max_text_length}

  enum role: [:trainee, :supervisor]

  scope :get_users_not_exist_in_course, ->(course_id) do
    where("id NOT IN (?)", UserCourse.get_users_id_in_course(course_id))
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end
end
