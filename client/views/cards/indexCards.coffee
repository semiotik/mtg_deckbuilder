typesFilter = new Blaze.ReactiveVar([])
colorsFilter = new Blaze.ReactiveVar([])
cardsSort = new Blaze.ReactiveVar([['name', 1]])
cardsSet = new Blaze.ReactiveVar(null)
cardsLibrary = new Blaze.ReactiveVar(null)
keyword = new Blaze.ReactiveVar('')
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
      cardsSet: cardsSet.get()
      cardsLibrary: cardsLibrary.get()
      keyword: keyword.get()
    @subscribe 'cards', options
    @subscribe 'decks'

Template.indexCards.helpers
  cards: ->
    Cards.find {}, sort: cardsSort.get()
  types: ->
    types.get()
  colors: ->
    colors.get()
  sets: ->
    sets.get()
  libraries: ->
    Libraries.find()

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
    cardsSet.set(e.currentTarget.value)
  'change .library-select': (e)->
    cardsLibrary.set(e.currentTarget.value)
  'change .search': (e)->
    keyword.set(e.currentTarget.value)
  'click .add-to-mine': (e)->
    amount = parseInt $('.counter-input input').val()
    Meteor.call('addCardToLibrary', @_id, amount)
  'click .remove-card': (e)->
    e.stopPropagation()
    Meteor.call('substractCardFromLibrary', @_id)
  'click .add-to-deck': (e)->
    Meteor.call('addCardToDeck', $(e.currentTarget).attr('data-card-id'), @_id)