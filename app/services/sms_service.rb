# frozen_string_literal: true

class SMSService
  BASE_URI = 'https://sms.ru'

  def initialize(message, user)
    @message = message
    @user = user
  end

  def send_message
    @options = default_params.merge({ query: { msg: message, to: user.phone_number } })

    send
  end

  private

  attr_reader :message, :options, :user

  def default_params
    { api_id: Rails.application.credentials.smsru[:api_id], json: 1 }
  end

  def send
    Faraday.get('/sms/send', options)
  end
end
