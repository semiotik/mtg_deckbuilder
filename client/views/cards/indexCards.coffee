Template.indexCards.helpers
  cards: ->
    Cards.find()
  cardsByCode: (code)->
    Cards.find code: code