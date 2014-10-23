# Description:
#   Tells you what gender the bot is feeling today.
#
# Commands:
#   hubot what is your gender - Displays what gender I'm feeling today
#
module.exports = (robot) ->
  robot.respond /what is your gender$/i, (msg) ->
    # Is it a new day? A brand new day, a brand new feeling.
    calcNeeded = false

    gender = robot.brain.get('gender')

    if gender
      current = new Date()
      date = new Date(gender.calculatedAt)

      calcNeeded = current.getDay() != date.getDay() ||
        current.getMonth() != date.getMonth() ||
        current.getYear() != date.getYear()
    else
      calcNeeded = true

    if calcNeeded
      gender = {
        calculatedAt: new Date(),
        malePercentage: Math.random() * 100
      }

      robot.brain.set('gender', gender)

    male = parseInt(gender.malePercentage)
    female = 100 - male

    feeling = if Math.random() < 0.5 # THIS COULD OBVIOUSLY BE BETTER
      "#{male}%/#{female}% male/female"
    else
      "#{female}%/#{male}% female/male"

    msg.send("I'm feeling #{feeling} today.")
