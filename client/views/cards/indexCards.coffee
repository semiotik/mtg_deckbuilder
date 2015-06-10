cardType = new Blaze.ReactiveVar()
Template.indexCards.helpers
  cards: ->
    options = {}
    options['types'] = cardType.get() if cardType.get()
    Cards.find(options)
  types: ->
    rawTypes = Cards.find().fetch()
    _(rawTypes).chain().pluck('types').flatten().uniq().value().sort()
Template.indexCards.events
  'change .type-select': (e)->
    cardType.set(e.target.value)