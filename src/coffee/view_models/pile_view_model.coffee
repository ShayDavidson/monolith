class Monolith.ViewModels.PileViewCollection extends Backbone.Collection
  model: Monolith.ViewModels.Card

class Monolith.ViewModels.PileViewModel extends Backbone.Model
  defaults:
    cards: null