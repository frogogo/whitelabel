Trestle.resource(:receipts) do
  menu do
    item :receipts, icon: 'fa fa-star'
  end

  scopes do
    scope :all
    scope :processing, -> { Receipt.processing }
    scope :approved, -> { Receipt.approved }
    scope :completed, -> { Receipt.completed }
    scope :rejected, -> { Receipt.rejected }
  end

  search do |query|
    if query
      Receipt.where('qr_string LIKE ?', "%#{query}%")
    else
      Receipt.all
    end
  end

  # Customize the table columns shown on the index view.

  table do
    column :id
    column :qr_string
    column :state
    column :reject_reason
    column :promotion
    column :user
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |_receipt|
    text_field :qr_string, disabled: true
    select :state, Receipt.states.keys
    select :reject_reason, Receipt.reject_reasons.keys, include_blank: true
    select :promotion_id, Promotion.all, include_blank: true
    text_area :data, disabled: true
  end

  params do |params|
    params.require(:receipt).permit(:state, :reject_reason, :promotion_id)
  end
end
