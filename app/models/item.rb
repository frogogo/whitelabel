# == Schema Information
#
# Table name: items
#
#  id               :bigint           not null, primary key
#  description      :text
#  discounted_price :float
#  image_url        :string
#  name             :string
#  price            :float
#  specs            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  promotion_id     :bigint
#
class Item < ApplicationRecord
  belongs_to :promotion

  validates :discounted_price, :name, :price, presence: true
end
