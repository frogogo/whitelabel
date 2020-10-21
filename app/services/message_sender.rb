# frozen_string_literal: true

module MessageSender
  def self.send_message(message, recipient = nil)
    MessageSender::SlackBot.new(message, recipient: recipient).send_message
    MessageSender::SMSRU.new(message, recipient: recipient).send_message
    MessageSender::Debug.new(message, recipient: recipient).send_message
  end
end
