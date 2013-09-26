# Description
#   Allows Hubot to post messages to a Logbot server
#   http://github.com/nilenso/logbot
#
# Dependencies:
#   None
#
# Configuration:
#   LOGBOT_URL
#
# Commands:
#   hubot logs
#
# Author:
#   timothyandrew

module.exports = (robot) ->
  options =
    logbot_url: process.env.LOGBOT_URL

  robot.hear /(.*)/i, (msg) ->
    msg.http("#{options.logbot_url}/api/messages")
      .post("body=#{msg.message.text}&nick=#{msg.message.user.name}") (err, res, body) ->
  
    

