class APM::CallbackController < ActionController::API
  before_action :authenticate

  def create
    @receipt = Receipt.find_by(uuid: permitted_params[:uuid])
    @promotion = Promotion.find_by(promo_id: permitted_params[:promoId])
    return head :not_found if @receipt.blank? || @promotion.blank?

    @receipt.update!(receipt_params)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    Rollbar.error("Receipt #{@receipt.qr_string} update failed. Record not saved: #{e}")

    render_error(:receipt_not_saved)
  end

  private

  def authenticate
    if request.headers[:authorization] != Rails.application.credentials.apm_check[:callback_token]
      Rollbar.error("Receipt validation failed: wrong credentials - #{headers[:authorization]}")

      head :unauthorized
    end
  end

  def permitted_params
    params.permit(
      :approved, :channel, :createdAt, :duplicate, :fnsReceipt, :meta, :promoId, :receiptDate,
      :receiptId, :rejectReason, :rejectKey, :rules, :rulesCount, :rulesPoints, :source, :state,
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
      state: state,
      reject_reason: ReceiptValidator::APMCheck::REJECT_REASONS[permitted_params[:rejectKey]],
      uuid: permitted_params[:uuid],
      promotion: @promotion
    }
  end

  def state
    case permitted_params[:state]
    when 'ARRIVED'
      :processing
    when 'REVIEWED'
      permitted_params[:approved] ? :approved : :rejected
    else
      Rollbar.error("Receipt #{@receipt.qr_string} validation failed: wrong receipt state.")
      :rejected
    end
  end
end
