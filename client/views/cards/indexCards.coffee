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
  Meteor.call 'getCardValues', (error, result)->
    types.set result.types
    colors.set result.colors
    sets.set result.sets
  @autorun =>
    options =
      types: typesFilter.get()
      colors: colorsFilter.get()
      cardSet: cardsSet.get()
    @subscribe 'cards', options
    @subscribe 'libraries'

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
  'change .type-checkboxes input': (e)->
    values = for input in $('.type-checkboxes input:checked')
      input.value
    typesFilter.set(values)
  'change .color-checkboxes input': (e)->
    values = for input in $('.color-checkboxes input:checked')
      if input.value == '' then null else input.value
    colorsFilter.set(values)
  'change .sort-select': (e)->
    updateCardsSort e.currentTarget.value
  'change .set-select': (e)->
    value = if e.currentTarget.value == '' then null else e.currentTarget.value
    cardsSet.set(value)
  'click .add-to-mine': (e)->
    amount = parseInt $('.counter-input input').val()
    Meteor.call('addCardToLibrary', @_id, amount)
  'click .remove-card': (e)->
    e.stopPropagation()
    Meteor.call('substractCardFromLibrary', @_id)