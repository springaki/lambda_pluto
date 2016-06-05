
index = require("./index")

describe "index", ->
  originalTimeout = null

  beforeEach ->
    originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL
    jasmine.DEFAULT_TIMEOUT_INTERVAL = 1000 * 10

  afterEach ->
    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout

  describe ".handler", ->
    it "", (done)->
      event = {
        "token": "J18JxxYCy1Yjx7dUWQ13Wg5j",
        "team_id": "T03Q7508W",
        "team_domain": "koberb",
        "service_id": "45918352615",
        "channel_id": "C1BSS8WEA",
        "channel_name": "spike",
        "timestamp": "1464657842.000002",
        "user_id": "U03Q7509E",
        "user_name": "spring.aki",
        "text": "<@U0D84LJG3> amzn  水"
      }
      context = {
        succeed: ->
          done()
        fail: (error)->
          fail(error)
          done()
      }
      index.handler(event, context)
