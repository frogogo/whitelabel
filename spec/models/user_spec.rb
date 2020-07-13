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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
