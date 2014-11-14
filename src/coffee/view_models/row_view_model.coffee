class Monolith.ViewModels.RowViewCollection extends Backbone.Collection
  model: Monolith.ViewModels.Card

class Monolith.ViewModels.RowViewModel extends Backbone.Model
  defaults:
    cards: null