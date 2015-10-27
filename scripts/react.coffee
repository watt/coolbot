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
  
  robot.respond /debug/, (res) ->
    options =
      noColor: true
    res.reply """
              ```
              #{prettyjson.render(res.message, options)}
              ```
              """
