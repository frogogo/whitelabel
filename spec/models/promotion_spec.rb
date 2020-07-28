# == Schema Information
#
# Table name: promotions
#
#  id                      :bigint           not null, primary key
#  api_token               :string           not null
#  description             :string
#  name                    :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  distribution_network_id :bigint           not null
#  promo_id                :integer          not null
#
# Indexes
#
#  index_promotions_on_distribution_network_id  (distribution_network_id)
#
# Foreign Keys
#
#  fk_rails_...  (distribution_network_id => distribution_networks.id)
#
require 'rails_helper'

RSpec.describe Promotion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
