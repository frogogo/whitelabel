class API::UsersController < APIController
  skip_before_action :authenticate_user, only: %i[create]

  def create
    @user = User.create_or_find_by!(phone_number: params[:phone_number])
    if @user.password_refresh_rate_limit_expires_at.blank?
      @user.set_new_password

      render status: :created
    else
      render_error(
        :password_refresh_rate_limit,
        options: { time_left: time_left_for(@user.password_refresh_rate_limit_expires_at) }
      )
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    render_error(:user_not_saved)
  end

  def show
    @user = current_user
  end

  def update
    current_user.update!(user_params)
    head :ok
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    render_error(:user_not_saved)
  end

  private

  def user_params
    params.permit(:email, :first_name)
  end
end
