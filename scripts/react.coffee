# Description:
#   React with emoji
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Andrew Watt

prettyjson = require("prettyjson")

module.exports = (robot) ->
  # robot.hear /.*/, (res) ->
  #   if res.message.user.name == "bag"
  #     res
  #       .http("https://slack.com/api/reactions.add")
  #       .query
  #         name: handbag
  #         channel: res.message.room
  #         timestamp: res.message.id
  #         token: process.env.SLACK_ACCESS_TOKEN
  robot.respond /are you there/, (res) ->
    res.send "Yes, I'm here!"

  robot.respond /debug/, (res) ->
    res.send "debug info:"
    options =
      noColor: true
    json = prettyjson.render(res.message, options)
    res.send  """
              ```
              #{json}
              ```
              """
