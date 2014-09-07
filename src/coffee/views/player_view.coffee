class App.Views.PlayerView extends Backbone.Marionette.LayoutView
  className: 'player'

  onRender: ->
    @$el.addClass(@model.get('side'))

  getTemplate: ->
    templateName = "##{@model.get('side')}-player-view"
    _.template($(templateName).html())