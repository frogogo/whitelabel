class API::HomeController <APIController
  def index
    @receipt = current_user.receipts.where.not(state: :completed).last
  end
end
