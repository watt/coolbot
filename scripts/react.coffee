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

bags = [
  "baggage_claim",
  "briefcase",
  "handbag",
  "moneybag",
  "pouch",
  "purse",
  "school_satchel",
  "typingshark"
]

module.exports = (robot) ->
    
  robot.hear /./, (res) ->
    return unless res.message.user.name == "bag"
    
    # Frequency is expressed as the percentage of bag's messages that will get reactions
    # The default is 10%.
    frequency = parseInt(process.env.HUBOT_BAG_FREQUENCY ? "10", 10)
    if frequency == 0 or frequency < Math.floor(Math.random() * 100)
      return
    
    emoji = res.random bags
        
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

  robot.respond /debug message/, (res) ->
    res.send """
             your message:
               username: #{res.message.user.name}
               channel name: #{res.message.room}
               slack channel: #{res.message.rawMessage?.channel}
               id: #{res.message.id}
             """

  robot.respond /are you there/, (res) ->
    res.send "Yes, I'm here!"
