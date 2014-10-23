# Description:
#   Gives you a random xkcd comic
#
# Commands:
#   hubot xkcd me - Displays a random xkcd comic
#

module.exports = (robot) ->
  robot.respond /xkcd me/i, (msg) ->
    
    # there's no api for random, so get the most recent comic number to use as
    # an upper bound for the random function, then GET that comic number
    msg.http("http://xkcd.com/info.0.json")
      .get() (err, res, body) ->
        currentComic = JSON.parse(body).num
        randomComic = randomExcept404(1, currentComic)

        msg.http("http://xkcd.com/#{randomComic}/info.0.json")
          .get() (err, res, body) ->
            comic = JSON.parse(body)
            msg.send("#{comic.num} - #{comic.title}")
            msg.send(comic.img)
            msg.send("Alt text: #{comic.alt}")

# there is no comic #404, so don't return 404 randomly
randomExcept404 = (min, max) ->
  rand = Math.floor(Math.random() * (max - min + 1) + min)

  if rand isnt 404
    return rand
  else randomExcept404(min, max)
