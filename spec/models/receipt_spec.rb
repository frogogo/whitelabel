# == Schema Information
#
# Table name: receipts
#
#  id            :bigint           not null, primary key
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
#  index_receipts_on_uuid          (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (promotion_id => promotions.id)
#
require 'rails_helper'

RSpec.describe Receipt, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
