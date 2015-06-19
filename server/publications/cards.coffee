buildQuery = (options)->
  query = {}
  query['types'] = {$in: options.types} if options.types.length
  query['colors'] = {$in: options.colors} if options.colors.length
  query['code'] = options.cardSet if options.cardSet
  query['library_ids'] = options.library_id if options.library_id
  query

Meteor.publish 'cards', (options)->
  query = buildQuery options
  Cards.find query