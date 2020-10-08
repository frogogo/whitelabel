Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-star'
  end

  scopes do
    scope :all
    scope :new, -> { User.new_registered }
  end

  search do |query|
    if query
      User.where('phone_number LIKE ?', "%#{query}%")
    else
      User.all
    end
  end

  # Customize the table columns shown on the index view.

  table do
    column :phone_number
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |_user|
    text_field :email
    text_field :first_name
    text_field :phone_number
    select :role, User.roles.keys
  end

  params do |params|
    params.require(:user).permit(:email, :first_name, :phone_number, :role)
  end
end
