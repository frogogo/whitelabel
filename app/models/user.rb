# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  phone_number    :string           not null
#  first_name      :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
class User < ApplicationRecord
  PASSWORD_LENGTH = 4
  PASSWORD_MAX_NUMBER = 9999

  has_secure_password validations: false

  validates :phone_number, presence: true

  def self.from_token_request(request)
    phone_number = request.params['auth'] && request.params['auth']['phone_number']
    find_by(phone_number: phone_number)
  end

  def is_new
    email.blank? || first_name.blank?
  end

  def set_new_password
    new_password = generate_password
    self.password = new_password
    save!

    SMSService.new("Poprobuy.ru code: #{new_password}", self).send_message
  end

  private

  def generate_password
    SecureRandom.random_number(PASSWORD_MAX_NUMBER).to_s.rjust(PASSWORD_LENGTH, '0')
  end
end
