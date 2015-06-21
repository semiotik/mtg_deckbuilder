@Cards = new Mongo.Collection 'cards'
Cards.attachSchema(Schemas.Card)
Cards.helpers
  amountInLibrary: (libraryId = '1')->
    Libraries.findOne(libraryId).cardAmountByCardId(@_id)