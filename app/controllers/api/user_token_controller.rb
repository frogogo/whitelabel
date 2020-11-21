class API::UserTokenController < Knock::AuthTokenController
  def create
    @user = entity
    @token = auth_token.token
    render status: :created
  end

  private

  def authenticate
    raise Knock.not_found_exception_class unless entity.present? && entity.authenticate(auth_params)
  end

  def auth_params
    params.permit(:phone_number, :password, :refresh_token)
  end
end
