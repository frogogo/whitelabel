class APIController < ActionController::API
  include ActionController::Caching
  include Knock::Authenticable

  DEFAULT_LOCALE = :ru
  LIMIT = 100
  START_FROM = 1

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
end
