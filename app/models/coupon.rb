# == Schema Information
#
# Table name: coupons
#
#  id         :bigint           not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class Coupon < ApplicationRecord
  GIFT_THRESHOLD = 3300

  belongs_to :user, optional: true

  scope :unassigned, -> { where(user: nil) }
end
