# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE)
#  bar_code        :string           not null
#  name            :string           not null
#  quantity        :integer
#  size            :string           not null
#  start_quantity  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  manufacturer_id :bigint
#  promotion_id    :bigint
#
# Indexes
#
#  index_items_on_manufacturer_id  (manufacturer_id)
#  index_items_on_promotion_id     (promotion_id)
#
# Foreign Keys
#
#  fk_rails_...  (manufacturer_id => manufacturers.id)
#  fk_rails_...  (promotion_id => promotions.id)
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
