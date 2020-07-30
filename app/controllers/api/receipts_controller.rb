class API::ReceiptsController < APIController
  START_FROM = 1
  LIMIT = 190

  def index
    start_from = params[:start_from] || START_FROM
    limit = params[:limit] || LIMIT

    @receipts = current_user.receipts.where(id: start_from..).order(created_at: :desc).limit(limit)
  end

  def create
    current_user.receipts.create!(receipts_params)

    head :created
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActiveRecord::RecordNotUnique
    head :unprocessable_entity
  end

  private

  def receipts_params
    params.permit(:qr_string)
  end
end
