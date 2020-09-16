# frozen_string_literal: true

class MessageSender::SMSService < MessageSender::Default
  BASE_URI = 'https://sms.ru'
  SENDER = 'poprobuy'

  def send_message
    @options = default_params.merge({ msg: message, to: user.phone_number })

    send
  end

  private

  def default_params
    { api_id: Rails.application.credentials.smsru[:api_id], from: SENDER, json: 1 }
  end

  def send
    Faraday.get("#{BASE_URI}/sms/send", options)
  end
end
