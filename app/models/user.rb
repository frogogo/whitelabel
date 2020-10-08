# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :string
#  first_name    :string
#  phone_number  :string           not null
#  refresh_token :string           not null
#  role          :integer          default("general"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_phone_number   (phone_number) UNIQUE
#  index_users_on_refresh_token  (refresh_token) UNIQUE
#
class User < ApplicationRecord
  include Assignable

  PASSWORD_LENGTH = 4
  PASSWORD_LIFETIME = 5.minutes
  PASSWORD_MAX_NUMBER = 9999
  PASSWORD_REFRESH_RATE = 1.minute
  REFRESH_TOKEN_LENGTH = 32

  enum role: {
    general: 0,
    developer: 1
  }

  has_many :receipts, dependent: :destroy

  validates :phone_number, presence: true

  before_create :generate_refresh_token

  scope :new_registered, -> { where(email: nil, first_name: nil) }

  def self.from_token_request(request)
    phone_number = request.params['phone_number']
    refresh_token = request.params['refresh_token']

    if phone_number.present?
      find_by(phone_number: phone_number)
    elsif refresh_token.present?
      user = find_by(refresh_token: refresh_token)
      return if user.blank?

      user.generate_refresh_token && user.save!
      user
    end
  end

  def authenticate(unencrypted_password)
    return false if password_digest.blank?

    BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end

  def generate_refresh_token
    self.refresh_token = SecureRandom.hex(REFRESH_TOKEN_LENGTH)
  end

  def new?
    email.blank? || first_name.blank?
  end

  def password_digest
    Rails.cache.read(password_key)
  end

  def password_refresh_rate_limit
    Rails.cache.read(password_refresh_rate_limit_key)
  end

  def password=(unencrypted_password)
    new_password_digest = BCrypt::Password.create(unencrypted_password, cost: BCrypt::Engine.cost)

    Rails.cache.write(password_key, new_password_digest, expires_in: PASSWORD_LIFETIME)
    Rails.cache.write(password_refresh_rate_limit_key, true, expires_in: PASSWORD_REFRESH_RATE)
  end

  def set_new_password
    new_password = SecureRandom.random_number(PASSWORD_MAX_NUMBER).to_s.rjust(PASSWORD_LENGTH, '0')
    self.password = new_password

    MessageSender.new("Poprobuy.ru code: #{new_password}", self).send_message
  end

  private

  def password_key
    "user:#{id}:password-digest"
  end

  def password_refresh_rate_limit_key
    "user:#{id}:password-refresh-rate-limit"
  end
end
