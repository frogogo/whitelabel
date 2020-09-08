class APIController < ActionController::API
  include ActionController::Caching
  include Knock::Authenticable

  LIMIT = 100
  START_FROM = 1

  before_action :authenticate_user

  def limit
    params[:limit] || LIMIT
  end

  def start_from
    params[:start_from] || START_FROM
  end
end
