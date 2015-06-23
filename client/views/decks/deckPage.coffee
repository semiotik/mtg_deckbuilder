sorting = new Blaze.ReactiveVar {cmc: 1}

Template.deckPage.helpers
  cards: ->
    Cards.find {}, sort: sorting.get()

Template.deckPage.onCreated ->
  @options = new Blaze.ReactiveVar
    id: Router.current().params._id
  @sorting = new Blaze.ReactiveVar {cmc: 1}
  @autorun =>
    @subscribe 'deckCards', @options.get()

Template.deckPage.rendered = ->
  @autorun =>
    context = $('#mana-curve')[0].getContext('2d')
    chartData =
      labels: ['0', '1', '2', '3', '4', '5', '6+']
      datasets: [{data: @data.manaCurve()}]
    chart = new Chart(context).Line(chartData, null)

Template.deckPage.events
  'mouseover .card-preview': (e)->
    $(e.currentTarget).closest('.deck-card').find('.card-image').show()
  'mouseout .card-preview': (e)->
    $(e.currentTarget).closest('.deck-card').find('.card-image').hide()