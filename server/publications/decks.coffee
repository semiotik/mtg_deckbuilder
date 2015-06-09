Meteor.publish "decks", ->
  Decks.find()