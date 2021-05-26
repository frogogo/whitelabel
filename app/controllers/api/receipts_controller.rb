class API::ReceiptsController < APIController
  def index
    @receipts =
      current_user.receipts
        .includes(:item, :promotion)
        .where(id: start_from..).order(created_at: :desc).limit(limit)
  end

  def create
    @receipt = current_user.receipts.build(receipts_params)

    if @receipt.save
      render :show, status: :created
    else
      render json: { error: @receipt.errors.details.first.last.first[:error],
                     error_text: @receipt.errors.values.first },
             status: :unprocessable_entity
    end
  end

  private

  def receipts_params
    params.permit(:qr_string)
  end
end
