@Cards = new Mongo.Collection 'cards'
Cards.attachSchema(Schemas.Card)
Cards.helpers
  sumValuesInArray: (array, value)->
    amount = 0
    if array
      for arrayValue in array
        amount++ if arrayValue == value
    amount

  amountInLibrary: (library_id = 1)->
    @sumValuesInArray(@library_ids, library_id)
  amountInDeck: (deck_id = 1)->
    @sumValuesInArray(@deck_ids, deck_id)