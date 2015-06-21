@Schemas = {}
Schemas.Card = new SimpleSchema
  name:
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
  manaCost:
    type: String
    optional: true
  cmc:
    type: Number
    optional: true
  rarity:
    type: String
  artist:
    type: String
  text:
    type: String
    optional: true
  code:
    type: String
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
  loyalty:
    type: Number
    optional: true
  starter:
    type: Boolean
    optional: true
  layout:
    type: String
  library_ids:
    type: [Number]
    defaultValue: []
  deck_ids:
    type: [Number]
    defaultValue: []
Schemas.Library = new SimpleSchema
  name:
    type: String
Schemas.Deck = new SimpleSchema
  name:
    type: String