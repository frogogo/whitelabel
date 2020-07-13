# frozen_string_literal: true

class SMSService
  include HTTParty

  base_uri 'https://sms.ru'
  default_params api_id: Rails.application.credentials.smsru[:api_id], json: 1
  format :json

  def initialize(message, user)
    @message = message
    @user = user
  end

  def send_message
    @options = { query: { msg: message, to: user.phone_number } }

    send
  end

  private

  attr_reader :message, :options, :user

  def send
    self.class.get('/sms/send', options)
  end
end
