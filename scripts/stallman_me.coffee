# Commands:
#   hubot stallman me - show a picture of RMS working
module.exports = (robot) ->
  robot.hear /stallman me/i, (msg) ->
    total_stallmans = 147

    number = Math.floor(Math.random() * total_stallmans) + 1
    root = "https://www.stallman.org/photos/rms-working"
    url = "#{root}/pages/#{number}.html"

    robot.logger.debug("hitting url: #{url}")

    robot.http(url).get() (err, res, body) ->
      if err
        msg.send "got an error: #{err}"
        return

      image = body.match(/(mid\/.+?.jpg)"/i)[1]
      image_url = "#{root}/#{image}"

      msg.send(image_url)
