cardFilter = new Blaze.ReactiveVar({})
updateCardFilter: (newOptions)->
  currentOptions = cardFilter.get()
  for key, value in newOptions
    currentOptions[key] = value
  cardFilter.set(currentOptions)
Template.indexCards.helpers
  cards: ->
    Cards.find(cardFilter.get())
  types: ->
    rawTypes = Cards.find().fetch()
    _(rawTypes).chain().pluck('types').flatten().uniq().value().sort()
Template.indexCards.events
  'change .type-select': (e)->
    updateCardFilter({type: e.target.value})