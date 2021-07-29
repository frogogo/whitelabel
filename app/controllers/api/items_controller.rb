class API::ItemsController < APIController
  before_action :set_item, only: %i[show]

  def index
    @items = Promotion.active.first.items
  end

  def show
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
