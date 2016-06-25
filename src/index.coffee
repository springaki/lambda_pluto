require('dotenv').config()

slack_icon_url = process.env.SLACK_ICON_URL
bot_name = process.env.BOT_NAME

request = require 'requestretry'
cheerio = require 'cheerio'
https = require 'https'

client = require('cheerio-httpcli')

exports.handler = (event, context) ->
  console.log(JSON.stringify(event))
  console.log(JSON.stringify(context))

  if event.user_name.match ///(Twitter|#{bot_name})///i
    console.log("ignore bot!!!  event.user_name.match!!")
    return

  msg = event.text.match /(<@U0D84LJG3>|pluto) +(book|amazon|amzn) +(.*)/i
  console.log("msg: " + JSON.stringify(msg))
  if !msg
    return

  keyword = msg[3]
  base_url = 'http://www.amazon.co.jp/s/ref=nb_sb_noss?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&url=search-alias%3Daps&field-keywords='
  keywords = keyword.split(",")

  console.log("keywords: " + JSON.stringify(keywords))

  keywords.forEach (val, index, ar) ->
    console.log("val: " + JSON.stringify(val))
    url = base_url + encodeURIComponent(val.trim())

    options =
      url: url
      timeout: 2000
      headers: {'user-agent': 'node title fetcher'}
      maxAttempts: 5
      retryDelay: 1000

    console.log("url: " + JSON.stringify(url))

    response_url = ''
    request options, (error, response, body) ->
      if body
        # console.log("error: " + error)
        $ = cheerio.load body
        title = $('title').text().replace(/\n/g, '')
        # console.log("title: " + title)
        # console.log("data-asin.attr: " + $('.s-result-item').attr('data-asin'))
        asociate_url = 'http://www.amazon.co.jp/dp/' + $('.s-result-item').attr('data-asin') + '?tag=hubot-pluto-22'

        bitly_api_url = 'https://api-ssl.bitly.com/v3/shorten?access_token=820673759628b8575c881f95d17f9d226e6b2395&longUrl=' + asociate_url
        response = https.get(bitly_api_url, (res) ->
          body = ''
          res.setEncoding 'utf8'
          res.on 'data', (chunk) ->
            body += chunk
            return
          res.on 'end', (res) ->
            ret = JSON.parse(body)
            response_url = ret.data.url

            slack_option =
              username: 'pluto'
              icon_url: slack_icon_url
              text: response_url
              parse: "full"
              unfurl_links: "true"
            console.log("slack_option: " + JSON.stringify(slack_option))

            context.done null, slack_option
            return
          return
        ).on 'error', (e) ->
          #エラー時
          console.log("error message: " +  e.message)
          return

      else
        console.log("error: " + error)
        text = [
          'request failed.'
          error
          response
        ].join('\n')
