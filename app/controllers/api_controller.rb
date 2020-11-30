class APIController < ActionController::API
  include ActionController::Caching
  include Knock::Authenticable

  DEFAULT_LOCALE = :ru
  LIMIT = 100
  START_FROM = 1
  TIME_FORMAT = '%H:%M:%S'.freeze

  before_action :authenticate_user

  around_action :switch_locale

  def limit
    params[:limit] || LIMIT
  end

  def start_from
    params[:start_from] || START_FROM
  end

  def switch_locale(&action)
    I18n.with_locale(locale, &action)
  end

  private

  def locale
    http_accept_language.preferred_language_from(I18n.available_locales) || DEFAULT_LOCALE
  end

  def render_error(error, status: :unprocessable_entity, options: {})
    options[:scope] = [:controllers, controller_name]

    render json: { error: error, error_text: I18n.t(error, options) }, status: status
  end

  def time_left_for(expires_at)
    Time.at(expires_at - Time.current).utc.strftime(TIME_FORMAT)
  end
end
