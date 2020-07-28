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
#  user_id       :bigint           not null
#
# Indexes
#
#  index_receipts_on_promotion_id  (promotion_id)
#  index_receipts_on_qr_string     (qr_string) UNIQUE
#  index_receipts_on_user_id       (user_id)
#  index_receipts_on_uuid          (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (promotion_id => promotions.id)
#  fk_rails_...  (user_id => users.id)
#
class Receipt < ApplicationRecord
  enum state: {
    processing: 0,
    approved: 1,
    completed: 2,
    rejected: 3
  }

  belongs_to :promotion, optional: true
  belongs_to :user

  before_create :set_data

  def number
    data['i'].to_i
  end

  def sum
    data['s'].to_i
  end

  def timestamp
    data['t'].to_time.iso8601
  end

  private

  def set_data
    self.data = CGI.parse(qr_string)
    self.data = data.each { |key, value| data[key] = value.join }
  end
end
