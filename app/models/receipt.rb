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
class Receipt < ApplicationRecord
  QR_STRING_REGEXP = /\At=(?<t>\w+)&s=(?<s>\d+.\d+)&fn=(?<fn>\d+)&i=(?<i>\d+)&fp=(?<fp>\d+)&n=(?<n>\d)\z/.freeze
  USER_LIMIT_PERIOD = 24.hours

  enum reject_reason: {
    invalid_date: 0,
    invalid_sum: 1,
    invalid_data: 2,
    duplicate: 3,
    limit_reached: 4,
    system_error: 5
  }

  enum state: {
    processing: 0,
    approved: 1,
    completed: 2,
    rejected: 3
  }

  validate :user_daily_limit_not_reached, if: :new_record?
  validate :user_has_no_processing_receipt, if: :new_record?
  validate :promotion_present, if: -> { approved? || completed? }
  validate :item_present, if: :completed?
  validates :qr_string, presence: true, uniqueness: true, format: { with: QR_STRING_REGEXP }

  belongs_to :item, optional: true
  belongs_to :promotion, optional: true
  belongs_to :user

  before_create :set_data
  before_create :set_promotion, if: -> { promotion.blank? }

  after_create_commit :validate_receipt

  def number
    data['i'].to_i
  end

  def sum
    data['s'].to_i
  end

  def timestamp
    data['t'].to_time.iso8601
  end

  def reject_reason_text
    self.class.human_attribute_name("reject_reasons.#{reject_reason}")
  end

  private

  def item_present
    return if item.present?

    errors.add(:item, :required)
  end

  def promotion_present
    return if promotion.present?

    errors.add(:promotion, :required)
  end

  def set_data
    self.data = qr_string.match(QR_STRING_REGEXP).named_captures
  end

  def set_promotion
    self.promotion = Promotion.active.first
  end

  def user_daily_limit_not_reached
    return if user.receipts.where(created_at: (Time.current - USER_LIMIT_PERIOD)..).none?

    errors.add(:base, :limit_reached)
  end

  def user_has_no_processing_receipt
    return if user.receipts.processing.none?

    errors.add(:base, :processing_receipt_exist)
  end

  def validate_receipt
    ReceiptValidator.validate(self)
  end
end
