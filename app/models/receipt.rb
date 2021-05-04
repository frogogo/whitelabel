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
class Receipt < ApplicationRecord
  QR_STRING_REGEXP = /\At=(?<t>\w+)&s=(?<s>\d+.\d+)&fn=(?<fn>\d+)&i=(?<i>\d+)&fp=(?<fp>\d+)&n=(?<n>\d)\z/.freeze
  USER_LIMIT_PERIOD = 1.minute

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

  belongs_to :promotion, optional: true
  belongs_to :user

  before_create :set_promotion, if: -> { promotion.blank? }

  after_create_commit :validate_receipt

  after_update_commit :assign_coupon, if: -> { saved_change_to_state? && approved? }

  scope :unapproved, -> { where.not(state: :approved) }

  def number
    qr_keys['i'].to_i
  end

  def sum
    qr_keys['s'].to_i
  end

  def timestamp
    qr_keys['t'].to_time.iso8601
  end

  def reject_reason_text
    self.class.human_attribute_name("reject_reasons.#{reject_reason}")
  end

  private

  def assign_coupon
    coupons_to_assign = user.total_sum / Coupon::GIFT_THRESHOLD - user.coupons.count
    return if coupons_to_assign <= 0

    coupons_to_assign.times do
      Coupon.unassigned.first.update_attribute(:user, user)
    end
  end

  def item_present
    return if item.present?

    errors.add(:item, :required)
  end

  def promotion_present
    return if promotion.present?

    errors.add(:promotion, :required)
  end

  def qr_keys
    qr_string.match(QR_STRING_REGEXP).named_captures
  end

  def set_promotion
    self.promotion = Promotion.active.first
  end

  def user_daily_limit_not_reached
    last_receipt = user.receipts.where.not(state: :rejected)
                       .where(created_at: (Time.current - USER_LIMIT_PERIOD)..).last
    return if last_receipt.blank?

    errors.add(
      :base,
      :limit_reached,
      time_left: Time.at(last_receipt.created_at - Time.current)
                     .utc.strftime(APIController::TIME_FORMAT)
    )
  end

  def user_has_no_processing_receipt
    return if user.receipts.processing.none?

    errors.add(:base, :processing_receipt_exist)
  end

  def validate_receipt
    # TEMP
    return if Rails.env.development?

    ReceiptValidator.validate(self)
  end
end
