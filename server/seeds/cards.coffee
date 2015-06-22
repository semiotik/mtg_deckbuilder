Meteor.startup ->
  packageNames = ['M15', 'THS', 'BNG', 'JOU', 'KTK', 'FRF', 'DTK', 'DGM']
  imageServiceUrl = 'http://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid='
  packageNames.forEach (packageName)->
    unless Cards.findOne({code: packageName})
      data = JSON.parse Assets.getText(packageName + '.json')
      cards = data['cards']
      cards.forEach (card)->
        card['code'] = packageName
        card['imageUrl'] = imageServiceUrl + card['multiverseid']
        Cards.insert card