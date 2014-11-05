class Monolith.ViewModels.PlayerViewModel extends Backbone.Model

  defaults:
    type: null # 'corp' or 'runner'
    side: null # 'left' or 'right'
    pile: null
    hand: null
    tokens: null
    credits: 0
    badPublicity: 0
    tags: 0
