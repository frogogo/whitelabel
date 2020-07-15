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
  has_secure_password validations: false

  validates :phone_number, presence: true

  def self.from_token_request(request)
    phone_number = request.params['auth'] && request.params['auth']['phone_number']
    find_by(phone_number: phone_number)
  end
end
