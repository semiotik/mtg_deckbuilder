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