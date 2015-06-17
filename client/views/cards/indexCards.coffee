typesFilter = new Blaze.ReactiveVar([])
colorsFilter = new Blaze.ReactiveVar([])
cardsSort = new Blaze.ReactiveVar([['name', 1]])
cardsSet = new Blaze.ReactiveVar(null)
types = new Blaze.ReactiveVar([])
colors = new Blaze.ReactiveVar([])
sets = new Blaze.ReactiveVar([])

updateCardsSort = (key)->
  options = [[key, 1]]
  options.push(['name', 1]) unless key == 'name'
  cardsSort.set(options)

Template.indexCards.onCreated ->
  Meteor.call 'getCardTypes', (error, result)->
    types.set(result)
  Meteor.call 'getCardColors', (error, result)->
    colors.set(result)
  Meteor.call 'getCardSets', (error, result)->
    sets.set(result)
  @autorun =>
    options =
      types: typesFilter.get()
      colors: colorsFilter.get()
      cardSet: cardsSet.get()
    @subscribe 'cards', options

Template.indexCards.helpers
  cards: ->
    Cards.find {}, sort: cardsSort.get()
  types: ->
    types.get()
  colors: ->
    colors.get()
  sets: ->
    sets.get()

Template.indexCards.events
  'change .sort-select': (e)->
    updateCardsSort e.currentTarget.value
  'change .type-checkboxes input': (e)->
    values = for input in $('.type-checkboxes input:checked')
      input.value
    typesFilter.set(values)
  'change .color-checkboxes input': (e)->
    values = for input in $('.color-checkboxes input:checked')
      if input.value == '' then null else input.value
    colorsFilter.set(values)
  'change .set-select': (e)->
    value = if e.currentTarget.value == '' then null else e.currentTarget.value
    cardsSet.set(value)