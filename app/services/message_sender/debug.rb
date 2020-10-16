class MessageSender::Debug < MessageSender::Default
  def send_message
    return unless Rails.env.development?

    send
  end

  private

  def send
    Rails.logger.debug("user:#{user.id} - #{message}")
  end
end
