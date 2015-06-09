@Cards = new Mongo.Collection 'cards'
Cards.attachSchema(Schemas.Card)