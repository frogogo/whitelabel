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
#  promo_id    :integer          not null
#
class Promotion < ApplicationRecord
  has_many :receipts, dependent: :destroy

  validates :api_token, presence: true
  validates :name, presence: true
  validates :promo_id, presence: true
end
