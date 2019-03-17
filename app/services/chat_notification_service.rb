# frozen_string_literal: true

class ChatNotificationService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def perform
    # Wrap Slack notification so that chat can be easily replaced to other services
    Slack::Notifier.new(ENV["SLACK_WEBHOOK_URL"]).ping(message)
  end
end
