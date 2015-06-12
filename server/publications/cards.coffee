buildQuery = (types, colors)->
  typesQuery = {types: {$in: types}} if types.length
  colorsQuery = {colors: {$in: colors}} if colors.length
  if typesQuery && colorsQuery
    {$and: [typesQuery, colorsQuery]}
  else
    typesQuery || colorsQuery || {}

Meteor.publish 'cards', (options)->
  query = buildQuery options.types, options.colors
  Cards.find query