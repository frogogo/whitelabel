class APM::CallbackController < ActionController::API
  before_action :authenticate

  def create
    @receipt = Receipt.find_by(uuid: permitted_params[:uuid])
    @promotion = Promotion.find_by(promo_id: permitted_params[:promoId])
    return head :not_found if @receipt.blank? || @promotion.blank?

    @receipt.update!(receipt_params)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    Rollbar.error("Receipt #{receipt.qr_string} update failed. Record not saved: #{e}")
    head :unprocessable_entity
  end

  private

  def authenticate
    raise SecurityError if headers[:authorization] != Rails.credentials.apm_check[:callback_token]
  end

  def permitted_params
    params.permit(
      :approved, :channel, :createdAt, :duplicate, :fnsReceipt, :meta, :promoId, :receiptDate,
      :receiptId, :rejectReason, :reject_key, :rules, :rulesCount, :rulesPoints, :source, :state,
      :userUuid, :uuid,
      photos: [], reviewiers: [],
      answers: [:products_with_count_and_subtotals, { products: %i[id count name] },
                { products_with_count: %i[id name] }, { total: %i[sum count sum_subtotal] }],
      city: %i[id city region address],
      promoPoints: %i[earned totalEarned leftovers leftoversInt],
      retailer: %i[id name inn store],
      total: %i[sum count sum_subtotal]
    )
  end

  def receipt_params
    {
      data: permitted_params,
      state: permitted_params[:approved] ? :approved : :rejected,
      reject_reason: ReceiptValidator::APMCheckValidator::REJECT_REASONS[permitted_params[:reject_key]],
      uuid: permitted_params[:uuid],
      promotion: @promotion
    }
  end
end
