# == Schema Information
#
# Table name: promotions
#
#  id          :bigint           not null, primary key
#  api_token   :string           not null
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Promotion < ApplicationRecord
  has_many :receipts

  validates :api_token, presence: true
  validates :name, presence: true
end
