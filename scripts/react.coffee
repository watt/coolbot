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
#   hubot react with <emoji> - make hubot add an emoji reaction
#   hubot are you there - check if hubot is working
#
# Author:
#   Andrew Watt

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
    
  robot.respond /debug message/, (res) ->
    res.send """
             your message:
               channel name: #{res.message.room}
               slack channel: #{res.message.rawMessage?.channel}
               id: #{res.message.id}
             """
  
  robot.respond /react with (\w+)/, (res) ->
    emoji = res.match[1]
    res.http("https://slack.com/api/reactions.add")
      .query
        name: emoji
        channel: res.message.rawMessage.channel
        timestamp: res.message.id
        token: process.env.HUBOT_SLACK_TOKEN
      .get() (err, resp, body) ->
        if err?
          robot.emit 'error', err, msg
          return

        if resp.statusCode != 200 || !JSON.parse(body).ok
          robot.logger.error "reaction failed: #{resp.statusCode} #{body}"
  
  robot.respond /are you there/, (res) ->
    res.send "Yes, I'm here!"
