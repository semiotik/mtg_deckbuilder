Meteor.publish "decks", ->
  Decks.find()
Meteor.publish "deck", (id)->
  Decks.find(id)
Meteor.publish "deckCards", (options)->
  deck = Decks.findOne(options.id)
  Cards.find
    _id: {$in: deck.cardIds()}