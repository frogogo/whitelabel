class API::UsersController < APIController
  skip_before_action :authenticate_user, only: %i[create]

  def create
    User.create_or_find_by!(phone_number: params[:phone_number]) do |user|
      user.set_new_password
    end
    render status :created
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordNotSaved
    render status :unprocessable_entity
  end

  def update
    current_user.update!(user_params)
    render status :ok
  rescue ActiveRecord::RecordNotSaved
    render status :unprocessable_entity
  end

  private

  def user_params
    params.permit(:email, :first_name)
  end
end
