# == Schema Information
#
# Table name: promotions
#
#  id         :bigint           not null, primary key
#  api_token  :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Promotion < ApplicationRecord
  validates :api_token, presence: true
  validates :name, presence: true
end
