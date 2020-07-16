class API::UserTokenController < Knock::AuthTokenController
  def create
    @user = entity
    @token = auth_token.token
    render status: :created
  end

  def auth_params
    params.permit(:phone_number, :password)
  end
end
