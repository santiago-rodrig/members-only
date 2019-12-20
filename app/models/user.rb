class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_many :posts
  before_create :set_token
  before_save { self.email.downcase! }
  has_secure_password
  validates :name, :email, presence: true, uniqueness: true
  validates :password, :password_confirmation, presence: true
  validates :password, :password_confirmation, length: { minimum: 6 }
  validates :email, format: { with: VALID_EMAIL_REGEX }

  def renew_token
    token = SecureRandom.urlsafe_base64
    update_attribute(
      :remember_token,
      Digest::SHA1.hexdigest(token)
    )

    token
  end

  private

  def set_token
    token = SecureRandom.urlsafe_base64
    self.remember_token = Digest::SHA1.hexdigest(token)

    token
  end
end
