class Monolith.Views.TokensPileView extends Backbone.Marionette.ItemView
  template: 'none'
  className: 'tokens-pile'

  PLACEMENT_PERCENT_MARGINS = 30
  ROTATION_RANDOM_RANGE = 40
  HALF_TOKEN_PERCENT = 15
  TOKEN_TEMPLATE = "<img class='token'></img>"
  TOKENS_IMAGE_PATH = '/images/tokens/'
  TOKENS_IMAGE_SUFFIX = '.png'

  onRender: ->
    @_renderTokens()

  _renderTokens: ->
    src = TOKENS_IMAGE_PATH + @options.type + TOKENS_IMAGE_SUFFIX
    _.times(@options.amount, =>
      tokenEl = $(TOKEN_TEMPLATE)
      tokenEl.attr(src: src)
      tokenEl.css(top: "#{@_randomPercentage()}%", left: "#{@_randomPercentage()}%")
      tokenEl.addClass("random-transform-#{Math.floor(Math.random() * ROTATION_RANDOM_RANGE)}")
      @$el.append(tokenEl)
    )

  _randomPercentage: ->
    Math.random() * (100 - (2 * PLACEMENT_PERCENT_MARGINS)) + PLACEMENT_PERCENT_MARGINS - HALF_TOKEN_PERCENT