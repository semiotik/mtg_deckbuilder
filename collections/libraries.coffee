@Libraries = new Mongo.Collection 'libraries'
Libraries.attachSchema(Schemas.Library)
Libraries.helpers
  cardIds: ->
  _(@cards).pluck('id')
  fullCards: ->
    Cards.find(_id: @cardIds)
  cardAmountByCardId: (cardId)->
    for card in @cards
      return card.amount if card.id == cardId
Meteor.methods
  'addCardToLibrary': (cardId, amount = 1, libraryId = '1')->
    library = Libraries.findOne(libraryId)
    cards = library.cards
    foundCard = false
    for card, i in cards
      if card.id == cardId
        cards[i].amount += amount
        foundCard = true
        break
    cards.push {id: cardId, amount: amount} unless foundCard
    Libraries.update(libraryId, {$set: {cards: cards}})