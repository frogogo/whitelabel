# frozen_string_literal: true

class MessageSender
  attr_reader :message, :user

  def initialize(message, user)
    @message = message
    @user = user
  end

  def send_message
    if Rails.env.production?
      send_via_sender
    else
      send_debug_info
    end
  end

  private

  def send_via_sender
    if user.developer?
      MessageSender::SlackBot.new(message, user).send_message
    else
      MessageSender::SMSService.new(message, user).send_message
    end
  end

  def send_debug_info
    Rails.logger.debug("user:#{user.id} - #{message}")
  end
end
