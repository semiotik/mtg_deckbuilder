@Schemas = {}
Schemas.Card = new SimpleSchema
  layout:
    type: String
  type:
    type: String
  types:
    type: [String]
  supertypes:
    type: [String]
    optional: true
  subtypes:
    type: [String]
    optional: true
  colors:
    type: [String]
    optional: true
  multiverseid:
    type: Number
  name:
    type: String
  rarity:
    type: String
  artist:
    type: String
  text:
    type: String
    optional: true
  number:
    type: String
  imageName:
    type: String
    optional: true
  imageUrl:
    type: String
  power:
    type: String
    optional: true
  toughness:
    type: String
    optional: true
  flavor:
    type: String
    optional: true
  cmc:
    type: Number
    optional: true
  loyalty:
    type: Number
    optional: true
  starter:
    type: Boolean
    optional: true
  code:
    type: String
Schemas.Deck = new SimpleSchema
  name:
    type: String
  cards:
    type: [Schemas.Card]