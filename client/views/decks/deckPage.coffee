sorting = new Blaze.ReactiveVar {cmc: 1}
chart = new Blaze.ReactiveVar(null)

Template.deckPage.helpers
  cards: ->
    Cards.find {}, sort: sorting.get()

Template.deckPage.onCreated ->
  @options = new Blaze.ReactiveVar
    id: Router.current().params._id
  @autorun =>
    @subscribe 'deckCards', @options.get()

Template.deckPage.onRendered ->
  @autorun =>
    if chart.get()?
      for value, i in @data.manaCurve()
        chart.get().datasets[0].points[i].value = value
      chart.get().update()
    else
      context = @$('#mana-curve')[0].getContext('2d')
      chartData =
        labels: ['0', '1', '2', '3', '4', '5', '6+']
        datasets: [{data: @data.manaCurve()}]
      chart.set(new Chart(context).Line(chartData, null))
    @$('.card-preview').imageLens({lensSize: 220})