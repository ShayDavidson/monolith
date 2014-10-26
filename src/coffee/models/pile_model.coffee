class Monolith.Models.PileCollection extends Backbone.Collection
  model: Monolith.Models.Card

class Monolith.Models.PileModel extends Backbone.Model
  defaults:
    cards: null