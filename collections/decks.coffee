@Decks = new Mongo.Collection 'decks'
Decks.attachSchema(Schemas.Deck)
Decks.helpers
  cardIds: ->
    _(@cards).pluck('id')
  fullCards: ->
    Cards.find(_id: @cardIds)
  cardAmountByCardId: (cardId)->
    for card in @cards
      return card.amount if card.id == cardId
Meteor.methods
  createDeck: (name)->
    Decks.insert({name: name})
  updateDeckName: (id, name)->
    Decks.update(id, {$set: {name: name}})
  addCardToDeck: (cardId, deckId, amount = 1)->
    cards = Decks.findOne(deckId).cards || []
    foundCard = false
    for card, i in cards
      if card.id == cardId
        cards[i].amount += amount
        foundCard = true
        break
    cards.push {id: cardId, amount: amount} unless foundCard
    Decks.update(deckId, {$set: {cards: cards}})