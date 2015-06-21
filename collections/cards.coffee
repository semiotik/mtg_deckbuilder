@Cards = new Mongo.Collection 'cards'
Cards.attachSchema(Schemas.Card)
Cards.helpers
  amountInLibrary: (library_id = '1')->
    Library.findOne(library_id).cardAmountByCardId(@_id)