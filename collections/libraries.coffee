@Libraries = new Mongo.Collection 'libraries'
Libraries.attachSchema(Schemas.Library)
Libraries.helpers
  cardIds: ->
    _(@cards).pluck('id')
  fullCards: ->
    Cards.find(_id: @cardIds)
Meteor.methods
  changeAmountInLibrary: (cardId, amount = 1, libraryId = '1')->
    cards = Libraries.findOne(libraryId).cards || []
    index = i for card, i in cards when card.id == cardId
    if index?
      cards[index].amount += amount
      cards.splice(index, 1) if cards[index].amount < 1
    else
      cards.push {id: cardId, amount: amount}
    Libraries.update(libraryId, {$set: {cards: cards}})