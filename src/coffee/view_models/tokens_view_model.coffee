class Monolith.ViewModels.TokensViewCollection extends Backbone.Collection
  model: Monolith.ViewModels.TokensViewModel

  ofType: (type) ->
    model = @findWhere(type: type)
    model = new Monolith.ViewModels.TokensViewModel(type: type) unless model
    model

  sample: ->
    @ofType(@first().get('type'))

class Monolith.ViewModels.TokensViewModel extends Backbone.Model

  TOKENS_IMAGE_PATH = '/images/tokens/'
  TOKENS_IMAGE_SUFFIX = '.png'

  PLACEMENT_PERCENT_MARGINS = 30
  HALF_TOKEN_SIZE_PERCENT = 20

  defaults:
    type: null # 'advancement', 'bad-publicity', 'brain-damage', 'credit', 'generic', 'tag', 'virus'
    amount: 0

  initialize: ->
    @_predetermineTokensPositions()

  imagePath: ->
    TOKENS_IMAGE_PATH + @get('type') + TOKENS_IMAGE_SUFFIX

  _predetermineTokensPositions: ->
    @positionForIndex = []
    _.times(@get('amount'), =>
      @positionForIndex.push({top: @_randomPercentageForPlacement(), left: @_randomPercentageForPlacement()})
    )

  _randomPercentageForPlacement: ->
    Math.random() * (100 - (2 * PLACEMENT_PERCENT_MARGINS)) + PLACEMENT_PERCENT_MARGINS - HALF_TOKEN_SIZE_PERCENT