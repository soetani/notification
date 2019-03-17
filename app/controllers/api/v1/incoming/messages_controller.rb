# frozen_string_literal: true

class Api::V1::Incoming::MessagesController < Api::ApiController
  def create
    from = params["From"]
    body = params["Body"]
    nickname = get_nickname(from)
    message = "From: #{nickname}\n-----\n#{body}"
    ChatNotificationService.new(message).perform
    render xml: "<Response></Response>"
  end

  private

    def get_nickname(phone_number)
      contact = Settings.contact.find { |person| person.phone == phone_number }
      contact.nil? ? Settings.anonymous_name : contact.nickname
    end
end
