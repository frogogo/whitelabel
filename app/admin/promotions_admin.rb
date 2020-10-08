Trestle.resource(:promotions) do
  menu do
    item :promotions, icon: 'fa fa-star'
  end

  scopes do
    scope :all
    scope :active, -> { Promotion.active }
    scope :inactive, -> { Promotion.inactive }
  end

  search do |query|
    if query
      Promotion.where('name ILIKE ?', "%#{query}%")
    else
      Promotion.all
    end
  end

  # Customize the table columns shown on the index view.

  table do
    column :name
    column :distribution_network
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |_promotion|
    check_box :active
    text_field :name
    text_field :description
    text_field :api_token, label: 'API token(APM)'
    text_field :promo_id, label: 'promo id(APM)'

    select :distribution_network_id, DistributionNetwork.all, include_blank: true
  end

  params do |params|
    params.require(:promotion).permit(:active, :api_token, :name, :description, :promo_id)
  end
end
