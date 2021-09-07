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
  REQUIRED_PARAMS = %w[t s fn i fp n]
  USER_LIMIT_PERIOD = 1.minute
  # TEMP
  TEST_RECEIPTS = {
    't=20210520T1242&s=120.00&fn=9282440300922865&i=57922&fp=3355367090&n=1' => 'approved',
    't=20210516T2002&s=577.49&fn=9280440300912346&i=77693&fp=162908629&n=1' => 'approved',
    't=20210520T1204&s=307.34&fn=9285440300331199&i=67786&fp=4117959914&n=1' => 'rejected',
    't=20210517T1439&s=1156.72&fn=9282440300712805&i=77300&fp=26521520&n=1' => 'rejected',
    't=20210517T1440&s=159.70&fn=9282440300712805&i=77301&fp=796665854&n=1' => 'processing',
    't=20210517T1440&s=285.14&fn=9282440300712805&i=77302&fp=2891260896&n=1' => 'processing'
  }

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

  # TEMP: enable in prod
  # validate :user_daily_limit_not_reached, if: :new_record?
  # validate :user_has_no_processing_receipt, if: :new_record?
  validates :qr_string, presence: true, uniqueness: true

  validate :promotion_present, if: -> { approved? || completed? }
  validate :item_present, if: :completed?
  validate :validate_qr_string_params, if: :new_record?

  belongs_to :promotion, optional: true
  belongs_to :user

  before_create :set_promotion, if: -> { promotion.blank? }

  # TEMP
  after_create_commit :set_state_for_test_receipts
  after_create_commit :validate_receipt

  after_update_commit :assign_coupon, if: -> { saved_change_to_state? && approved? }

  scope :unapproved, -> { where.not(state: :approved) }

  def number
    qr_string_params['i'][0].to_i
  end

  def sum
    return 1700 if I18n.locale == :en
    return 0 if data.blank?
    return 0 if data['total'].nil?

    data['total']['sum_subtotal'].to_i
  end

  def timestamp
    qr_string_params['t'][0].to_time.iso8601
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
    return if I18n.locale == :en
    return if Rails.env.development?

    ReceiptValidator.validate(self)
  end

  def qr_string_params
    @qr_string_params ||= CGI.parse(qr_string)
  end

  # TEMP
  def set_state_for_test_receipts
    return unless qr_string_params['state'].present? ||
                  qr_string.in?(TEST_RECEIPTS.keys)

    state = TEST_RECEIPTS.fetch(qr_string, nil)
    state = qr_string_params['state'][0] if state.nil?

    update_column(:state, state)
  end

  def validate_qr_string_params
    return if REQUIRED_PARAMS.all? { |key| qr_string_params.key? key }

    errors.add(:qr_string, :invalid)
  end
end
