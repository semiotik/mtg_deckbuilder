@Decks = new Mongo.Collection 'decks'
Decks.attachSchema(Schemas.Deck)