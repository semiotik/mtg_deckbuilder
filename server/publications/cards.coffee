buildQuery = (options)->
  query = {}
  query.types = {$in: options.types} if options.types.length
  query.colors = {$in: options.colors} if options.colors.length
  query.code = options.cardsSet if options.cardsSet
  query.library_ids = options.library_id if options.library_id
  if options.cardsLibrary
    cardIds = Libraries.findOne(options.cardsLibrary).cardIds()
    query._id = {$in: cardIds}
  query.text = new RegExp(options.keyword, 'i')
  query

Meteor.publish 'cards', (options)->
  query = buildQuery options
  Cards.find query