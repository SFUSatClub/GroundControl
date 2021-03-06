class User < ApplicationRecord

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  serialize :preferences, Hash

  validates :name, presence: true, length: {maximum: 50}
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}
  validates :password, confirmation: true, length: { minimum: 6, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, :on => :create
  validates :password, confirmation: true, length: { :within => 6..ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, :on => :update, :unless => lambda{ |user| user.password.blank? }

  has_secure_password

end
