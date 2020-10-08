Trestle.resource(:items) do
  active_storage_fields do
    [:image]
  end

  menu do
    item :items, icon: 'fa fa-star'
  end

  # scopes do
  #   scope :all
  #   scope :active, -> { Item.active }
  #   scope :inactive, -> { Item.inactive }
  #   scope :out_of_stock, -> { Item.out_of_stock }
  # end

  search do |query|
    if query
      Item.where('name ILIKE ?', "%#{query}%")
    else
      Item.all
    end
  end

  # Customize the table columns shown on the index view.

  table do
    column :name
    column :manufacturer
    column :promotion
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |_item|
    text_field :bar_code
    text_field :name
    number_field :start_quantity
    number_field :quantity, disabled: true
    text_field :size
    active_storage_field :image

    select :manufacturer_id, Manufacturer.all, include_blank: true
    select :promotion_id, Promotion.all, include_blank: true
  end

  params do |params|
    params.require(:item).permit(:bar_code, :name, :start_quantity, :size,
                                 :manufacturer_id, :promotion_id)
  end
end
