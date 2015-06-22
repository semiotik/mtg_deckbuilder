@Cards = new Mongo.Collection 'cards'
Cards.attachSchema(Schemas.Card)
Cards.helpers
  amountInLibrary: (libraryId = '1')->
    for card in Libraries.findOne(libraryId).cards
      return card.amount if card.id == @_id
    0
  freeAmount: ->
    amount = @amountInLibrary()
    Decks.find().forEach (deck) =>
      amountInDeck = deck.cardAmount(@_id)
      amount -= amountInDeck
    amount