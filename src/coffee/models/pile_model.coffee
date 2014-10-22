class App.Models.PileCollection extends Backbone.Collection
  model: App.Models.Card

class App.Models.PileModel extends Backbone.Model
  defaults:
    cards: null