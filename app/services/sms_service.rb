class SMSService
  include HTTParty
  base_uri 'https://sms.ru'

  def initialize(message, user)
    @message = message
    @user = user
  end

  def call
    @options = { query: { api_id: api_id, msg: message, to: user.phone_number, json: 1 }}

    send_message
  end

  private

  attr_reader :message, :options, :user

  def api_id
    Rails.application.credentials.smsru[:api_id]
  end

  def send_message
    self.class.get('/sms/send', options)
  end
end
