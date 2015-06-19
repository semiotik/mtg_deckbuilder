fetchValues = (collection, field)->
  rawValues = collection.fetch()
  _(rawValues).chain().pluck(field).flatten().uniq().value().sort()

Meteor.methods
  getCardValues: ->
    types: fetchValues(Cards.find(), 'types')
    colors: fetchValues(Cards.find(colors: {$exists: true}), 'colors')
    sets: fetchValues(Cards.find(), 'code')