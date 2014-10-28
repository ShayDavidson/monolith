class Monolith.Views.TokensPileView extends Backbone.Marionette.ItemView
  template: '#tokens-pile-view-template'
  className: 'tokens-pile'

  onRender: ->
    type = @options.type
    _.times(@options.amount, ->
      
    )