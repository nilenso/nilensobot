# Description:
#   This script sends expense information from Slack
#   to the Nilenso expenses email address.
#
# Dependencies:
#   "sendgrid": "1.0.4"
#
# Configuration:
#   SENDGRID_USERNAME
#   SENDGRID_PASSWORD 
#
# Commands:
#   hubot expense (c)ompany <amount> <description>
#   hubot expense (r)eimburse <amount> <description>
#
# Author:
#   timothyandrew

module.exports = (robot) ->
  sendMail = (msg, type, amount, description) ->
    sendgrid = require("sendgrid")(process.env.SENDGRID_USERNAME, process.env.SENDGRID_PASSWORD)
    sendgrid.send
      to: "expenses@nilenso.com"
      from: "nilensobot@nilenso.com"
      subject: type
      text: "Amount: #{amount}\nDescription: #{description}"
    , (err, json) ->
      if err
        robot.logger.error(err)
        msg.send "There was an error sending that email. Please try again (or look at the logs)."
      else
        console.log(json)
        msg.send "Email on the way."

  getType = (type) ->
    if type == "r" || type == "reimburse"
      "reimburse"
    else if type == "c" || type == "company"
      "company"  

  robot.respond /expense\s+(\S+)\s+(\d+)\s+(.*)/, (msg) ->
    type = getType(msg.match[1])

    unless type
      msg.send "That's an invalid type. The supported expense types are (c)ompany and (r)eimburse"
      return
    
    amount = msg.match[2]
    description = msg.match[3]
    sendMail(msg, type, amount, description)
    
    
