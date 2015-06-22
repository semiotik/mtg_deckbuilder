Meteor.publish "decks", ->
  Decks.find()
Meteor.publish "deck", (id)->
  Decks.find(id)
Meteor.publish "deckCards", (deckId)->
  deck = Decks.findOne(deckId)
  console.log Cards.find(_id: {$in: deck.cardIds()}).count()
  Cards.find(_id: {$in: deck.cardIds()})