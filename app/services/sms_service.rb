# frozen_string_literal: true

class SMSService
  BASE_URI = 'https://sms.ru'
  SENDER = 'poprobuy'

  def initialize(message, user)
    @message = message
    @user = user
  end

  def send_message
    if Rails.env.production?
      @options = default_params.merge({ msg: message, to: user.phone_number })

      send
    else
      Rails.logger.debug("user:#{user.id} - #{message}")
    end
  end

  private

  attr_reader :message, :options, :user

  def default_params
    { api_id: Rails.application.credentials.smsru[:api_id], from: SENDER, json: 1 }
  end

  def send
    Faraday.get("#{BASE_URI}/sms/send", options)
  end
end
