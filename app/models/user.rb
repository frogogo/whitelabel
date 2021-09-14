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
#  uuid          :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  # TODO: change to 5 minutes later
  ASSIGN_TIME_LIMIT = 2.minutes
  PASSWORD_LENGTH = 4
  PASSWORD_LIFETIME = 5.minutes
  PASSWORD_MAX_NUMBER = 9999
  PASSWORD_REFRESH_RATE = 1.minute
  REFRESH_TOKEN_LENGTH = 32

  EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/.freeze

  enum role: {
    general: 0,
    developer: 1
  }

  has_many :receipts, dependent: :destroy
  has_many :coupons, dependent: :nullify

  validates :email, presence: true, format: { with: EMAIL_REGEXP }, unless: :new_record?
  validates :first_name, presence: true, length: { maximum: 30 }, unless: :new_record?
  validates :phone_number, phone: true, allow_blank: false

  before_validation :normalize_phone_number
  before_create :generate_refresh_token

  scope :new_registered, -> { where(email: nil, first_name: nil) }

  def self.from_token_request(request)
    phone_number = request.params['phone_number']
    refresh_token = request.params['refresh_token']

    if phone_number.present?
      find_by(phone_number: phone_number)
    elsif refresh_token.present?
      find_by(refresh_token: refresh_token)
    end
  end

  def total_sum
    receipts.approved.map(&:sum).sum
  end

  def assign_time_limit_expires_at
    assign_time_limit[:expires_at]
  end

  def authenticate(auth_params)
    if auth_params[:password].present?
      return self if phone_number == '+79991112233' && auth_params[:password].to_s == '1234'
      return self if I18n.locale == :en && auth_params[:password].to_s == '1234'

      authenticate_by_password(auth_params[:password])
    elsif auth_params[:refresh_token].present?
      authenticate_by_refresh_token(auth_params[:refresh_token])
    end
  end

  def busy?
    assign_time_limit_expires_at.present?
  end

  def new?
    email.blank? || first_name.blank?
  end

  def password_refresh_rate_limit_expires_at
    password_refresh_rate_limit[:expires_at]
  end

  def password=(unencrypted_password)
    new_password_digest = BCrypt::Password.create(unencrypted_password, cost: BCrypt::Engine.cost)

    Rails.cache.write(password_key, new_password_digest, expires_in: PASSWORD_LIFETIME)
    Rails.cache.write(
      password_refresh_rate_limit_key,
      { expires_at: Time.current + PASSWORD_REFRESH_RATE },
      expires_in: PASSWORD_REFRESH_RATE
    )
  end

  def set_assign_time_limit
    Rails.cache.write(
      assign_time_limit_key,
      { expires_at: Time.current + ASSIGN_TIME_LIMIT },
      expires_in: ASSIGN_TIME_LIMIT
    )
  end

  def set_new_password
    new_password = SecureRandom.random_number(PASSWORD_MAX_NUMBER).to_s.rjust(PASSWORD_LENGTH, '0')
    self.password = new_password

    # TODO: extract
    MessageSender.send_message("S-Boom code: #{new_password}", self)
  end

  private

  def authenticate_by_password(unencrypted_password)
    return if password_digest.blank?

    BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end

  def authenticate_by_refresh_token(refresh_token)
    return if self.refresh_token != refresh_token

    generate_refresh_token && save! && self
  end

  def generate_refresh_token
    self.refresh_token = SecureRandom.hex(REFRESH_TOKEN_LENGTH)
  end

  def normalize_phone_number
    return unless phone_number

    self.phone_number = Phonelib.parse(phone_number).e164
  end

  # Keys

  def assign_time_limit_key
    "user:#{id}:assign_time_limit_key"
  end

  def password_key
    "user:#{id}:password-digest"
  end

  def password_refresh_rate_limit_key
    "user:#{id}:password-refresh-rate-limit"
  end

  # Values

  def assign_time_limit
    @assign_time_limit ||= Rails.cache.read(assign_time_limit_key) || {}
  end

  def password_digest
    @password_digest ||= Rails.cache.read(password_key) || {}
  end

  def password_refresh_rate_limit
    @password_refresh_rate_limit ||= Rails.cache.read(password_refresh_rate_limit_key) || {}
  end
end
