class API::ItemsController < APIController
  def index
    @items = Promotion.active.first.items
  end
end
