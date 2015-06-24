@Decks = new Mongo.Collection 'decks'
Decks.attachSchema(Schemas.Deck)
Decks.helpers
  cardIds: ->
    _(@cards).pluck('id')
  fullCards: ->
    Cards.find(_id: $in: @cardIds())
  cardAmount: (cardId)->
    for card in @cards
      return card.amount if card.id == cardId
    0
  cardsCount: ->
    sum = 0
    if @cards?
      sum += card.amount for card in @cards
      {unique: @cards.length, all: sum}
    else
      {unique: 0, all: 0}
  manaCurve: ->
    mana = []
    for i in [0..6]
      mana.push 0
    for card in @fullCards().fetch()
      break unless card.cmc?
      value = parseInt(card.cmc)
      if value > 6 then mana[6] += 1 else mana[value] += 1
    mana

Meteor.methods
  createDeck: (name)->
    Decks.insert({name: name})
  updateDeckName: (id, name)->
    Decks.update(id, {$set: {name: name}})
  changeAmountInDeck: (cardId, deckId, amount = 1)->
    cards = Decks.findOne(deckId).cards || []
    index = i for card, i in cards when card.id == cardId
    if index?
      cards[index].amount += amount
      cards.splice(index, 1) if cards[index].amount < 1
    else
      cards.push {id: cardId, amount: amount}
    Decks.update(deckId, {$set: {cards: cards}})