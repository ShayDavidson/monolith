class App.Views.BaseCardView extends Backbone.Marionette.ItemView
  template: _.template($('#card-view-template').html())
  className: 'card'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'

  onRender: ->
    if @model.get('faceUp')
      @model.preloadImage().then(=>
        @$el.addClass('faceUp').css('background-image': "url('#{@model.imagePath()}')")
      )
    else
      @$el.removeClass('faceUp').css('background-image': '')
