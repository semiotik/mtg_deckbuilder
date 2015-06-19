@Libraries = new Mongo.Collection 'libraries'
Libraries.attachSchema(Schemas.Library)
Libraries.helpers
  cards: ->
    Cards.find('library_ids': @_id)