class App.Views.PlayerView extends Backbone.Marionette.ItemView
  template: _.template($('script#player').html())
  className: 'player'

  onRender: ->
    @$el.addClass(@model.get('side'))