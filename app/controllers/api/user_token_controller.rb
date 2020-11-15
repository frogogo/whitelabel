class API::UserTokenController < Knock::AuthTokenController
  def create
    @user = entity
    @token = auth_token.token
    render status: :created
  end

  private

  def authenticate
    unless entity.present? && entity.authenticate(auth_params)
      raise Knock.not_found_exception_class
    end
  end

  def auth_params
    params.permit(:phone_number, :password, :refresh_token)
  end
end
