class MessageSender::Debug < MessageSender::Default
  def send_message
    return unless Rails.env.development?

    send
  end

  private

  def send
    Rails.logger.debug("recipient:#{recipient.class.name.parameterize}:#{recipient.id} - #{message}")
  end
end
