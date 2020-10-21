# frozen_string_literal: true

class MessageSender::Default
  def initialize(message, recipient: nil)
    @message = message
    @recipient = recipient
  end

  def send_message
    raise NotImplementedError
  end

  private

  attr_reader :message, :options, :recipient
end
