class Monolith.Views.BaseCardView extends Backbone.Marionette.LayoutView
  template: '#card-view-template'
  className: 'card'

  regions:
    tokens: '.tokens-pile'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'

  onRender: ->
    @_renderTokens()
    @_renderPreloading()

  _renderTokens: ->
    @tokens.show(new Monolith.Views.TokensPileView(model: @model.get('tokens').sample())) if @model.has('tokens')

  _renderPreloading: ->
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
