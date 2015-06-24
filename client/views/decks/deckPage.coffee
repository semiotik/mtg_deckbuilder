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
    dataset = {data: @data.manaCurve()}
    if @chart?
      for value, i in @data.manaCurve()
        @chart.get().datasets[0].points[i].value = value
      @chart.get().update()
    else
      context = $('#mana-curve')[0].getContext('2d')
      chartData =
        labels: ['0', '1', '2', '3', '4', '5', '6+']
        datasets: [dataset]
      chart = new Chart(context).Line(chartData, null)
      @chart = new Blaze.ReactiveVar(chart)

Template.deckPage.events
  'mouseover .card-preview': (e)->
    $(e.currentTarget).closest('.deck-card').find('.card-image').show()
  'mouseout .card-preview': (e)->
    $(e.currentTarget).closest('.deck-card').find('.card-image').hide()