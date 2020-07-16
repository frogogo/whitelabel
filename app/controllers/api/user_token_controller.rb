class API::UserTokenController < Knock::AuthTokenController
  def auth_params
    params.permit :phone_number, :password
  end
end
