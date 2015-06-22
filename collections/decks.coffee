@Decks = new Mongo.Collection 'decks'
Decks.attachSchema(Schemas.Deck)
Decks.helpers
  cardIds: ->
    _(@cards).pluck('id')
  fullCards: ->
    Cards.find(_id: @cardIds)
  cardAmount: (cardId)->
    for card in @cards
      return card.amount if card.id == cardId
    0

Meteor.methods
  createDeck: (name)->
    Decks.insert({name: name})
  updateDeckName: (id, name)->
    Decks.update(id, {$set: {name: name}})
  changeAmountInDeck: (cardId, deckId, amount = 1)->
    cards = Decks.findOne(deckId).cards || []
    index = i for card, i in cards when card.id == cardId
    if index?
      cards[index].amount += amount
      cards.splice(index, 1) if cards[index].amount < 1
    else
      cards.push {id: cardId, amount: amount}
    Decks.update(deckId, {$set: {cards: cards}})