# == Schema Information
#
# Table name: receipts
#
#  id            :bigint           not null, primary key
#  data          :jsonb            not null
#  qr_string     :string           not null
#  reject_reason :integer
#  state         :integer          default("processing"), not null
#  uuid          :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  promotion_id  :bigint
#
# Indexes
#
#  index_receipts_on_promotion_id  (promotion_id)
#  index_receipts_on_qr_string     (qr_string) UNIQUE
#  index_receipts_on_uuid          (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (promotion_id => promotions.id)
#
class Receipt < ApplicationRecord
  store_accessor :data, :fn, :fp, :i, :s, :t

  enum state: {
    processing: 0,
    approved: 1,
    completed: 2,
    rejected: 3
  }

  belongs_to :promotion, optional: true

  before_create :set_data

  private

  def set_data
    self.data = CGI::parse(qr_string)
  end
end
