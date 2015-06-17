buildQuery = (options)->
  typesQuery = {types: {$in: options.types}} if options.types.length
  colorsQuery = {colors: {$in: options.colors}} if options.colors.length
  if typesQuery && colorsQuery
    query = {$and: [typesQuery, colorsQuery]}
  else
    query = typesQuery || colorsQuery || {}
  query['code'] = options.cardSet if options.cardSet
  query

Meteor.publish 'cards', (options)->
  query = buildQuery options
  Cards.find query