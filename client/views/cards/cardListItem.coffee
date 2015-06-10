Template.cardListItem.events
  'mouseenter .card-list-item': (e)->
    $('#card-wrapper').html ''
    Blaze.renderWithData(Template.card, this, $('#card-wrapper')[0])