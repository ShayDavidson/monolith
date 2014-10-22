class App.Models.CardCollection extends Backbone.Collection
  model: App.Models.CardModel

class App.Models.CardModel extends Backbone.Model
  defaults:
    cardId: null
    faceUp: false