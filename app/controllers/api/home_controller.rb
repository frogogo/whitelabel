class API::HomeController < APIController
  def index
    @receipt =
      current_user.receipts.includes(:item, :promotion)
                  .where.not(state: :completed).last
  end
end
