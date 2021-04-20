class API::HomeController < APIController
  def index
    @receipt =
      current_user.receipts
                  .includes(:item, :promotion)
                  .order(created_at: :asc)
                  .last
  end
end
