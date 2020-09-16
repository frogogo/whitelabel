# frozen_string_literal: true

class MessageSender::Default
  def initialize(message, user)
    @message = message
    @user = user
  end

  def send_message
    raise NotImplementedError
  end

  private

  attr_reader :message, :options, :user
end
