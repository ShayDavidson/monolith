class App.Views.PlayerView extends Backbone.Marionette.CompositeView
  className: 'player'
  template: _.template($('#player-view-template').html())
  childView: App.Views.PileView
  childViewContainer: '.piles'

  initialize: (options) ->
    @collection = options.model.get('piles')

  onRender: ->
    @$el.addClass(@model.get('side'))