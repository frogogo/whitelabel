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
#  item_id       :bigint
#  promotion_id  :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_receipts_on_item_id       (item_id)
#  index_receipts_on_promotion_id  (promotion_id)
#  index_receipts_on_qr_string     (qr_string) UNIQUE
#  index_receipts_on_user_id       (user_id)
#  index_receipts_on_uuid          (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (promotion_id => promotions.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Receipt, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
