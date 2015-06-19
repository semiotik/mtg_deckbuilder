@Decks = new Mongo.Collection 'decks'
Decks.attachSchema(Schemas.Deck)
Decks.helpers
  cards: ->
    Cards.find('deck_ids': @_id)