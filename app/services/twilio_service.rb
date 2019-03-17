# frozen_string_literal: true

class TwilioService
  def send_sms(to:, message:)
    client.api.account.messages.create(from: ENV["TWILIO_NUMBER"], to: to, body: message)
  end

  private
    def client
      @client ||= Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    end
end
