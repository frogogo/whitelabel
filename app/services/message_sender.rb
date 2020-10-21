# frozen_string_literal: true

module MessageSender
  def self.send_message(message, recepient = nil)
    MessageSender::SlackBot.new(message, recepient: recepient).send_message
    MessageSender::SMSRU.new(message, recepient: recepient).send_message
    MessageSender::Debug.new(message, recepient: recepient).send_message
  end
end
