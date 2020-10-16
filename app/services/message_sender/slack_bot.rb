# frozen_string_literal: true

class MessageSender::SlackBot < MessageSender::Default
  SLACK_CHANNEL = '#web_debug'

  def send_message
    return unless Rails.env.production?
    return unless user.developer?

    send
  end

  private

  def client
    @client ||= Slack::Web::Client.new
  end

  def send
    client.chat_postMessage(channel: SLACK_CHANNEL, text: message, as_user: true)
  end
end
