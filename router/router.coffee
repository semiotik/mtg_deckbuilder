Router.map ->
  @route 'indexCards',
    path: 'cards'
    waitOn: ->
      Meteor.subscribe 'libraries'
  @route 'indexDecks',
    path: 'decks'
    waitOn: ->
      Meteor.subscribe 'decks'
  @route 'deckPage',
    path: 'decks/:_id'
    data: ->
      Decks.findOne()
    waitOn: ->
      Meteor.subscribe 'deck', @params._id
      Meteor.subscribe 'deckCards', @params._id
      Meteor.subscribe 'libraries'