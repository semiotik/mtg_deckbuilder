Template.navbar.helpers
  pages: ->
    for page in ['decks', 'cards']
      { name: page, path: "/#{page}" }