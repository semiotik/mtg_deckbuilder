typesFilter = new Blaze.ReactiveVar([])
colorsFilter = new Blaze.ReactiveVar([])
cardsSort = new Blaze.ReactiveVar([['name', 1]])

createOrCondition = (key, values)->
  unless values.length == 0
    data = for value in values
      param = {}
      param[key] = value
      if key == 'colors' && value == 'empty'
        param[key] = {$exists: false}
      param
    {$or: data}

filterOptions = ->
  types = createOrCondition('types', typesFilter.get())
  colors = createOrCondition('colors', colorsFilter.get())
  if types && colors
    options = {$and: [types, colors]}
  else
    types || colors || {}

updateCardsSort = (key)->
  options = [[key, 1]]
  options.push(['name', 1]) unless key == 'name'
  cardsSort.set(options)

Template.indexCards.helpers
  cards: ->
    Cards.find(filterOptions(), {sort: cardsSort.get()})
  types: ->
    rawTypes = Cards.find().fetch()
    _(rawTypes).chain().pluck('types').flatten().uniq().value().sort()
  colors: ->
    rawColors = Cards.find(colors: {$exists: true}).fetch()
    _(rawColors).chain().pluck('colors').flatten().uniq().value().sort()

Template.indexCards.events
  'change .sort-select': (e)->
    updateCardsSort e.currentTarget.value
  'change .type-checkboxes input': (e)->
    values = for input in $('.type-checkboxes input:checked')
      input.value
    typesFilter.set(values)
  'change .color-checkboxes input': (e)->
    values = for input in $('.color-checkboxes input:checked')
      input.value
    colorsFilter.set(values)