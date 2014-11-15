class Monolith.ViewModels.PlayerViewModel extends Backbone.Model
  defaults:
    type: null # 'corp' or 'runner'
    side: null # 'left' or 'right'
    rows: null
    hand: null
    tokens: null