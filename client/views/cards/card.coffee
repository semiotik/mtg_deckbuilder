amount = new Blaze.ReactiveVar(0)

Template.card.onCreated ->
  @autorun =>
    amount.set(@data.amountInLibrary())
Template.card.helpers
  amount: ->
    amount.get()