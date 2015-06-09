Template.indexCards.helpers
  cards: ->
    Cards.find()
  cardsByCode: (code)->
    Cards.find code: code
Template.indexCards.events
  
$('.nav li').removeClass 'active'
$('#nav-cards').addClass 'active'