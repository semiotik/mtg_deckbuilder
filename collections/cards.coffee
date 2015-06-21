@Cards = new Mongo.Collection 'cards'
Cards.attachSchema(Schemas.Card)
sumValuesInArray = (array, value)->
  amount = 0
  for arrayValue in array
    amount++ if arrayValue == value
  amount

Cards.helpers
  amountInLibrary: (library_id = 1)->
    sumValuesInArray(@library_ids || [], library_id)
  amountInDeck: (deck_id = 1)->
    sumValuesInArray(@deck_ids, deck_id)