class App.Views.PlayerView extends Backbone.Marionette.CompositeView
  className: 'player'
  template: '#player-view-template'
  childView: App.Views.PileView
  childViewContainer: '.piles-region'

  initialize: (options) ->
    @collection = options.model.get('piles')

  onRender: ->
    @$el.addClass(@model.get('side'))