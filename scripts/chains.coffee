# Description:
#   chains.cc utilities
#
# Commands:
#   hubot show chains - shows the current status of chains

module.exports = (robot) ->
  robot.respond /show chains/i, (msg) ->
    url = "https://api.chains.cc/v4/groups/fp2CrXQrKwqpCfk"
    text = "```\nCurrent 日本語 chains\n#{url}\n\n"

    msg.http(url)
      .query(limit: 40)
      .get() (err, res, body) ->
        result = JSON.parse(body)
        chains = result.braids

        for chain in chains
          chainMarks = chain.boolean_array.slice(0)
          chainLength = 0

          while (chainMarks.pop() == 1)
            chainLength += 1

          name = chain.user.realname.split(/\s+/)[0]

          text += "#{name} / #{chain.name} / streak: #{chainLength} days\n"
          text += "  "

          for [1..chainLength]
            text += "X"

          text += "\n\n"

        text = text.trim()
        text += "```"

        msg.send(text)
