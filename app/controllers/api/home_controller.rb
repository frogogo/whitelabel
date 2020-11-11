class API::HomeController < APIController
  def index
    @receipt =
      current_user.receipts.includes(:item, promotion: :distribution_network)
                  .where.not(state: :completed).order(created_at: :desc).last
  end
end
