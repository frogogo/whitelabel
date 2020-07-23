class API::UsersController < APIController
  skip_before_action :authenticate_user, only: %i[create]

  class PasswordPresentError < StandardError; end

  def create
    @user = User.create_or_find_by!(phone_number: params[:phone_number])
    raise PasswordPresentError if @user.password_digest.present?

    @user.set_new_password

    render status: :created
  rescue PasswordPresentError
    render json: { status: :too_many_requests }, status: :too_many_requests
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordNotSaved
    render json: { status: :unprocessable_entity }, status: :unprocessable_entity
  end

  def show
    @user = current_user
  end

  def update
    current_user.update!(user_params)
    render json: { status: :ok }, status: :ok
  rescue ActiveRecord::RecordNotSaved
    render json: { status: :unprocessable_entity }, status: :unprocessable_entity
  end

  private

  def user_params
    params.permit(:email, :first_name)
  end
end
