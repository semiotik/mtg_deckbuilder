Template.indexCards.helpers
  cardsByPackage: (package)->
    Cards.find({ code: package })