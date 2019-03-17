# Send bulk SMS from Slack using Twilio<br>Receive SMS on Slack using Twilio
[![CircleCI](https://circleci.com/gh/soetani/sms_notification/tree/master.svg?style=svg&circle-token=84de0d328f205fa6b96f294b43e1c4a55ed54cae)](https://circleci.com/gh/soetani/notification/tree/master)

A Rails app to send and receive SMS using **Twilio** and **Slack**.

The app is suitable for sending messages to your employees or team members.<br>
e.g. emergency alert, event alert

You can:
- Send same message to people in contact list of `config/settings.yml` from Slack using Twilio
- Receive SMS on Slack using Twilio

![sample](https://user-images.githubusercontent.com/15981348/54493186-7c40e980-48ff-11e9-8e79-003f9853585b.gif)

## How to use
Because `config/settings.yml` needs to be modified, deploy to Heroku button is not available.

### 1. Set up Twilio
1. Sign up for [Twilio](https://www.twilio.com/) (Provides API for SMS)
2. Get ACCOUNT SID<br>**This will be `TWILIO_ACCOUNT_SID`**
3. Get AUTH TOKEN<br>**This will be `TWILIO_AUTH_TOKEN`**
4. Get a number<br>**This will be `TWILIO_NUMBER`**

### 2. Set up Slack
1. [Create incoming webhook](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks) (This allows to receive message on Slack.)<br>
**This will be `SLACK_WEBHOOK_URL`**

### 3. Duplicate repository
1. Duplicate this repository to your account.<br>
Because `config/settings.yml` needs to be modified and forked repository always remains public, please duplicate the repository.<br>
See: [Duplicating a repository - GitHub](https://help.github.com/en/articles/duplicating-a-repository)

### 4. Modify `config/settings.yml`
1. Update `contact` in `config/settings.yml`.<br>
People in contact will be receive SMS when you send message on Slack.

```yml
contact:
  -
    nickname: John
    phone: "+11234567890"
  -
    nickname: Taro
    phone: "+819012345678"
  -
    nickname: Nguyen
    phone: "+84123456789"
```

### 5. Deploy to Heroku
1. Deploy the app to Heroku (The app doesn't use database.)<br>
**Your app name will be used later.**
2. Add `ruby` to Buildpacks
3. Add config vars
    - `TWILIO_ACCOUNT_SID`: See step 1-2
    - `TWILIO_AUTH_TOKEN`: See step 1-3
    - `TWILIO_NUMBER`: See step 1-4
    - `SLACK_WEBHOOK_URL`: See step 2-1
4. Restart the dyno

### 6. Set up Slack (One more time)
1. [Create outgoing webhook](https://slack.com/apps/A0F7VRG6Q-outgoing-webhooks) (This allows to send message from Slack.)<br>
**Trigger Word: `sms`**<br>
If you change the trigger word, please update `outgoing.messages.slack_trigger_word` in `config/settings.yml`.<br>
**URL: `https://your-heroku-app.herokuapp.com/api/v1/outgoing/messages`**<br>
See your Heroku app name at step 5-1.

### 7. Set up Twilio (One more time)
1. Set up Messaging webhook (This allows to receive message on Slack.)<br>
Visit [here](https://www.twilio.com/console/phone-numbers/incoming) and click the number to set up webhook.<br>
Messaging => A MESSAGE COMES IN =><br>
Webhook / **`https://your-heroku-app.herokuapp.com/api/v1/incoming/messages`** / HTTP POST<br>
See your Heroku app name at step 5-1.

## License

The app is released under the [MIT License](https://opensource.org/licenses/MIT).
