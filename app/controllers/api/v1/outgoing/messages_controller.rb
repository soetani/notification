# frozen_string_literal: true

class Api::V1::Outgoing::MessagesController < Api::ApiController
  def create
    settings = Settings.outgoing.messages
    slack_message = params["text"].sub(settings.slack_trigger_word, "").strip

    sms_message = "#{slack_message}\n\n#{settings.sms_footer_message} #{ENV['TWILIO_NUMBER']}"
    send_sms(sms_message)

    slack_reply_message = "#{settings.slack_reply_message}\n-----\n#{slack_message}"
    render json: { text: slack_reply_message }
  end

  private

    def send_sms(message)
      Settings.contact.each do |contact|
        TwilioService.new.send_sms(to: contact.phone, message: message)
      end
    end
end
