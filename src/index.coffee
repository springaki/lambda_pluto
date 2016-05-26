dotenv = require('dotenv').config()

slack_icon_url = process.env.SLACK_ICON_URL

exports.handler = (event, context) ->
  text = [
    JSON.stringify(event)
    JSON.stringify(context)
    event.token
    event.team_id
    event.team_domain
    event.channel_id
    event.channel_name
    event.timestamp
    event.user_id
    event.user_name
    event.trigger_word
  ].join('\n')
  text = [
    '```' + text + '```'
    event.text
  ].join('\n')
  context.done null,
    username: 'Twitter'
    icon_url: slack_icon_url
    text: text
