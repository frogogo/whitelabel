class APIController < ActionController::API
  include ActionController::Caching
  include Knock::Authenticable

  before_action :authenticate_user
end
