# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  email        :string
#  first_name   :string
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_phone_number  (phone_number) UNIQUE
#
class User < ApplicationRecord
  PASSWORD_LENGTH = 4
  PASSWORD_LIFETIME = 5.minutes
  PASSWORD_MAX_NUMBER = 9999

  validates :phone_number, presence: true

  def self.from_token_request(request)
    phone_number = request.params['phone_number']
    find_by(phone_number: phone_number)
  end

  def authenticate(unencrypted_password)
    return false if password_digest.blank?

    BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end

  def new?
    email.blank? || first_name.blank?
  end

  def password_digest
    Rails.cache.read(password_key)
  end

  def password=(unencrypted_password)
    new_password_digest = BCrypt::Password.create(unencrypted_password, cost: BCrypt::Engine.cost)

    Rails.cache.write(password_key, new_password_digest, expires_in: PASSWORD_LIFETIME)
  end

  def set_new_password
    new_password = SecureRandom.random_number(PASSWORD_MAX_NUMBER).to_s.rjust(PASSWORD_LENGTH, '0')
    self.password = new_password

    SMSService.new("Poprobuy.ru code: #{new_password}", self).send_message
  end

  private

  def password_key
    "user:#{id}:password-digest"
  end
end
