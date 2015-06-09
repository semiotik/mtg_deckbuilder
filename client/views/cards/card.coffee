Template.card.events
  'mouseenter .card': (e)->
    img = $(e.currentTarget).find('.card-image').clone()
    $('#card-image-view').html(img)