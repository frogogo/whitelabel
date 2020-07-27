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
require 'rails_helper'

RSpec.describe Promotion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
