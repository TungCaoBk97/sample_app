class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user_valid.max_email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :name, length: {maximum: Settings.user_valid.max_name_length},
    presence: true
  validates :password, presence: true,
    length: {minimum: Settings.user_valid.min_pass_length}
  before_save :email_downcase
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def email_downcase
    self.email = email.downcase
  end
end
