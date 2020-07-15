class API::UserTokenController < Knock::AuthTokenController
  def auth_params
    params.require(:auth).permit :phone_number, :password
  end
end
