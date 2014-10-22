class App.Views.BaseCardView extends Backbone.Marionette.ItemView
  template: _.template('')
  className: 'card'
  tagName: 'img'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'

  onRender: ->
    if @model.get('faceUp')
      @model.preloadImage().then(=>
        @$el.attr(src: @model.imagePath())
      )
    else
      @$el.attr(src: ASPECT_RATIO_IMG)
