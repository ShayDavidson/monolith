class Monolith.Views.BaseCardView extends Backbone.Marionette.ItemView
  template: '#card-view-template'
  className: 'card'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'

  onRender: ->
    if @model.get('faceUp')
      @_showLoadingSpinner()
      @model.preloadImage().then(=> @_onImageLoaded())
    else
      @$el.removeClass('faceUp').css('background-image': '')

  _showLoadingSpinner: ->
    setTimeout((=>
      @$el.addClass('loading') unless @$el.hasClass('faceUp')
    ), 100)

  _onImageLoaded: ->
    @$el.removeClass('loading')
        .addClass('faceUp')
        .css('background-image': "url('#{@model.imagePath()}')")
