class API::ReceiptsController < APIController
  START_FROM = 1
  LIMIT = 100

  def index
    start_from = params[:start_from] || START_FROM
    limit = params[:limit] || LIMIT

    @receipts = current_user.receipts.where(id: start_from..).order(created_at: :desc).limit(limit)
  end

  def create
    @receipt = current_user.receipts.create!(receipts_params)

    render status: :created
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    error = @receipt.errors.key?(:qr_string) ? :qr_string_invalid : :user_daily_limit_reached
    render json: { error: error }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotUnique
    render json: { error: :qr_string_not_unique }, status: :unprocessable_entity
  end

  private

  def receipts_params
    params.permit(:qr_string)
  end
end
