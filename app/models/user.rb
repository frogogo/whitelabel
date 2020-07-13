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
end
