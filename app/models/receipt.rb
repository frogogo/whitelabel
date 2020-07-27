# == Schema Information
#
# Table name: receipts
#
#  id            :bigint           not null, primary key
#  qr_string     :string           not null
#  reject_reason :integer
#  state         :integer          default("new"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  promotion_id  :bigint
#
# Indexes
#
#  index_receipts_on_promotion_id  (promotion_id)
#
# Foreign Keys
#
#  fk_rails_...  (promotion_id => promotions.id)
#
class Receipt < ApplicationRecord
  belongs_to :promotion, optional: true

  enum state: {
    new: 0,
    processing: 1,
    approved: 2,
    rejected: 3
  }
end
