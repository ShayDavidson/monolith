class Monolith.Views.TokensPileView extends Backbone.Marionette.ItemView
  template: 'none'
  className: 'tokens-pile'

  TOKEN_TEMPLATE =  $('#token-view-template').html()

  ROTATION_RANDOM_RANGE = 40

  PLACEMENT_PERCENT_MARGINS = 30
  HALF_TOKEN_SIZE_PERCENT = 20

  onRender: ->
    @_renderTokens()

  _renderTokens: ->
    _.times(@model.get('amount'), =>
      @$el.append(@_createTokenElement())
    )

  _createTokenElement: ->
    tokenEl = $(TOKEN_TEMPLATE)
    tokenEl.attr(src: @model.imagePath())
    tokenEl.css(top: "#{@_randomPercentageForPlacement()}%", left: "#{@_randomPercentageForPlacement()}%")
    tokenEl.addClass("random-transform-#{Math.floor(Math.random() * ROTATION_RANDOM_RANGE)}")
    tokenEl.addClass(@model.get('type'))

  _randomPercentageForPlacement: ->
    Math.random() * (100 - (2 * PLACEMENT_PERCENT_MARGINS)) + PLACEMENT_PERCENT_MARGINS - HALF_TOKEN_SIZE_PERCENT