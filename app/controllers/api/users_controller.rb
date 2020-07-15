class API::UsersController < APIController
  skip_before_action :authenticate_user, only: %i[create]

  def create
    User.create_or_find_by!(phone_number: params[:phone_number])
    head :created
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordNotSaved
    head :unprocessable_entity
  end

  def update
    current_user.update!(user_params)
    head :ok
  rescue ActiveRecord::RecordNotSaved
    head :unprocessable_entity
  end

  private

  def user_params
    params.permit(:email, :first_name)
  end
end
