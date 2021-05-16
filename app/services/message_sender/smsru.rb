# frozen_string_literal: true

class MessageSender::SMSRU < MessageSender::Default
  BASE_URI = 'https://sms.ru'
  SENDER = 'poprobuy'

  def send_message
    return unless Rails.env.production?
    return unless recipient.instance_of?(User)
    return unless recipient.general?

    @options = default_params.merge({ msg: message, to: recipient.phone_number })
    send
  end

  private

  def default_params
    { api_id: Rails.application.credentials.smsru[:api_id], json: 1 }
  end

  def send
    Faraday.get("#{BASE_URI}/sms/send", options)
  end
end
