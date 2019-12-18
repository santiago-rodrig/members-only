class User < ApplicationRecord
  has_many :posts
  before_create :set_token
  has_secure_password

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
