
index = require("./index")
cheerio = require 'cheerio'

describe "index", ->
  originalTimeout = null

  beforeEach ->
    originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL
    jasmine.DEFAULT_TIMEOUT_INTERVAL = 1000 * 10

  afterEach ->
    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout

  describe ".handler", ->
    it "", (done)->
      # event = {
      #   "token": "J18JxxYCy1Yjx7dUWQ13Wg5j",
      #   "team_id": "T03Q7508W",
      #   "team_domain": "koberb",
      #   "service_id": "45918352615",
      #   "channel_id": "C1BSS8WEA",
      #   "channel_name": "spike",
      #   "timestamp": "1464657842.000002",
      #   "user_id": "U03Q7509E",
      #   "user_name": "spring.aki",
      #   "text": "<@U0D84LJG3> amzn  水"
      # }
      event = {
        "token": "iKPSMPjVPGFA5NIKu2jR4nyk",
        "team_id": "T0J5E100N",
        "team_domain": "asayuki",
        "service_id": "41665115936",
        "channel_id": "C0K8E0G9J",
        "channel_name": "test2",
        "timestamp": "1466869427.000002",
        "user_id": "U0J5ALTJP",
        "user_name": "aki",
        "text": "pluto amzn 4817193603"
      }
      context = {
        succeed: ->
          done()
        fail: (error)->
          fail(error)
          done()
        done: ->
          done()
      }
      index.handler(event, context)

  describe "body", ->
    it "セレクタで取得可能か", (done)->
      $ = cheerio.load('<div id="atfResults" class="a-row s-result-list-parent-container">    <ul id="s-results-list-atf" class="s-result-list s-col-3 s-col-ws-4 s-result-list-hgrid s-height-equalized s-grid-view s-text-condensed" data-columns="{&quot;0&quot;:1,&quot;522&quot;:3,&quot;348&quot;:2}">        <li id="result_0" data-asin="B01E36Y88G" class="s-result-item  celwidget ">            <div class="s-item-container">                <div class="a-row sx-badge-region"></div>                <div class="a-row a-spacing-base">                    <div aria-hidden="true" class="a-column a-span12 a-text-left">                        <div class="a-section a-spacing-none a-inline-block s-position-relative">                            <a class="a-link-normal a-text-normal" target="_blank" href="http://www.amazon.co.jp/EERIE-VOL-1-2-3-4-5-SUSPENSE-Complete-ebook/dp/B01E36Y88G/ref=sr_1_1?ie=UTF8&amp;qid=1465138670&amp;sr=8-1&amp;keywords=12345"><img src="http://ecx.images-amazon.com/images/I/61R9wQczlLL._AC_US160_.jpg" srcset="http://ecx.images-amazon.com/images/I/61R9wQczlLL._AC_US160_.jpg 1x, http://ecx.images-amazon.com/images/I/61R9wQczlLL._AC_US240_FMwebp_QL65_.jpg 1.5x, http://ecx.images-amazon.com/images/I/61R9wQczlLL._AC_US320_FMwebp_QL65_.jpg 2x, http://ecx.images-amazon.com/images/I/61R9wQczlLL._AC_US400_FMwebp_QL65_.jpg 2.5x, http://ecx.images-amazon.com/images/I/61R9wQczlLL._AC_US480_FMwebp_QL65_.jpg 3x" width="160" height="160" alt="商品の詳細" class="s-access-image cfMarker" onload="viewCompleteImageLoaded(this, new Date().getTime(), 24, false);" data-search-image-load data-csm-markers="af,cf">                            </a><i class="s-badges-background-tl s-badges-tl s-badge-tl-popular"></i>                        </div>                    </div>                </div>            </div>        </li>    </ul></div>');
      expect($('.s-result-item').attr('data-asin')).toBe("B01E36Y88G")
      done()

    it "セレクタで取得可能か(テストhtml)", (done)->
      fs = require('fs')
      text = fs.readFileSync './src/test.html', 'utf8'
      $ = cheerio.load text
      expect($('.s-result-item').attr('data-asin')).toBe("B00LIW7ZQQ")
      done()

    it "正規表現テスト", (done)->
      bot_name = "hubot"
      match_string = "hubot".match ///(#{bot_name}|pluto)///i
      console.log("match_string: " + JSON.stringify(match_string))
      expect(match_string[0]).toBe("hubot")
      done()
