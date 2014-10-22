class App.Views.CardView extends Backbone.Marionette.ItemView
  template: _.template('')
  className: 'card'
  tagName: 'img'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'

  onRender: ->
    @$el.attr(src: ASPECT_RATIO_IMG)