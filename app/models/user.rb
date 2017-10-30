class User < ApplicationRecord

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}
  validates :password, confirmation: true, length: { minimum: 6, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }
  has_secure_password

end
