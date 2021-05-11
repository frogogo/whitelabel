class API::HomeController < APIController
  def index
    @receipts = current_user.receipts.order(created_at: :desc)
    @coupons = current_user.coupons.order(created_at: :desc)
  end
end
