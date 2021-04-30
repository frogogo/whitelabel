class API::HomeController < APIController
  def index
    @receipts = current_user.receipts
      .includes(:item, :promotion)
      .order(created_at: :asc)
  end
end
