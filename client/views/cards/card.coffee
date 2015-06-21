Template.card.onCreated ->
  @autorun =>
    @subscribe 'libraries'