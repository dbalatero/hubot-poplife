# Description:
#   chains.cc utilities
#
# Commands:
#   hubot show chains - shows the current status of chains

module.exports = (robot) ->
  robot.respond /show chains/i, (msg) ->
    url = "https://api.chains.cc/v4/groups/fp2CrXQrKwqpCfk"
    text = "```\nCurrent 日本語 chains\n"
    text += "https://chains.cc/groups/fp2CrXQrKwqpCfk\n\n"

    msg.http(url)
      .query(limit: 40)
      .get() (err, res, body) ->
        result = JSON.parse(body)
        chains = result.braids
        chainLength = 0

        for chain in chains
          chainMarks = chain.boolean_array.slice(0)
          chainLength = 0

          for index in [0...chainMarks.length]
            # ignore the first zero
            continue if chainMarks[index] == 0 && index == 0

            if chainMarks[index] == 1
              chainLength += 1
            else
              break

          name = chain.user.realname.split(/\s+/)[0]

          console.log "Chain length before text for #{name} #{chainLength}"

          text += "#{name} / #{chain.name} / streak: #{chainLength} days\n"
          text += "  "

          for [1..chainLength]
            text += "X"

          console.log "Chain length after text for #{name} #{chainLength}"

          text += "\n\n"

        text = text.trim()
        text += "```"

        msg.send(text)
