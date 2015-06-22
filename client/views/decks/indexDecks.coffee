Template.indexDecks.helpers
  decks: ->
    Decks.find()

Template.indexDecks.events
  'change .create-deck': (e)->
    name = e.currentTarget.value
    if name
      Meteor.call('createDeck', name)
      e.currentTarget.value = ''
  'click .edit-deck-name': (e)->
    e.stopPropagation()
    e.preventDefault()
    listItem = $(e.currentTarget).closest('.deck-list-item')
    listItem.find('.edit-deck-input').show()
    listItem.find('a').hide()
  'change .edit-deck-input': (e)->
    Meteor.call('updateDeckName', @_id, e.currentTarget.value)
    listItem = $(e.currentTarget).closest('.deck-list-item')
    listItem.find('.edit-deck-input').hide()
    listItem.find('a').show()