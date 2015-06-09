Router.map ->
  @route 'indexCards',
    path: 'cards',
    waitOn: -> [
      Meteor.subscribe 'cards'
    ]