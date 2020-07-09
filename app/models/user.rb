# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  phone_number :string           not null
#  first_name   :string
#  email        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class User < ApplicationRecord
  validates :phone_number, presence: true
end
