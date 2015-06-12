fetchValues = (collection, field)->
  rawValues = collection.fetch()
  _(rawValues).chain().pluck(field).flatten().uniq().value().sort()

Meteor.methods
  getCardTypes: ->
    fetchValues(Cards.find(), 'types')
  getCardColors: ->
    fetchValues(Cards.find(colors: {$exists: true}), 'colors')