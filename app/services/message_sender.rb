# frozen_string_literal: true

module MessageSender
  def send_message(message, user = nil)
    MessageSender::SlackBot.new(message, user).send_message
    MessageSender::SMSRU.new(message, user).send_message
    MessageSender::Debug.new(message, user).send_message
  end
end
