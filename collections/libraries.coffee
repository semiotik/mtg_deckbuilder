@Libraries = new Mongo.Collection 'libraries'
Libraries.attachSchema(Schemas.Library)
Libraries.helpers
  cardIds: ->
    _(@cards).pluck('id')
  fullCards: ->
    Cards.find(_id: @cardIds)
Meteor.methods
  addCardToLibrary: (cardId, libraryId = '1')->
    library = Libraries.findOne(libraryId)
    cards = library.cards
    foundCard = false
    for card, i in cards
      if card.id == cardId
        cards[i].amount += 1
        foundCard = true
        break
    cards.push {id: cardId, amount: 1} unless foundCard
    Libraries.update(libraryId, {$set: {cards: cards}})
  substractCardFromLibrary: (cardId, libraryId = '1')->
    library = Libraries.findOne(libraryId)
    cards = library.cards
    for card, i in cards
      if card.id == cardId
        if card.amount == 1
          cards.splice(i, 1)
        else
          cards[i].amount -= 1
        break
    Libraries.update(libraryId, {$set: {cards: cards}})