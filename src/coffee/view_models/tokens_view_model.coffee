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

  PREDETRMINED_POSITIONS_PER_AMOUNT = [
    [{top: 35, left: 35}],
    [{top: 25, left: 25}, {top: 45, left: 45}],
    [{top: 25, left: 25}, {top: 35, left: 45}, {top: 38, left: 25}],
  ]

  defaults:
    type: null # 'advancement', 'bad-publicity', 'brain-damage', 'credit', 'generic', 'tag', 'virus'
    amount: 0

  initialize: ->
    @_determineTokensPositions()

  imagePath: ->
    TOKENS_IMAGE_PATH + @get('type') + TOKENS_IMAGE_SUFFIX

  _determineTokensPositions: ->
    predeterminedAmount = PREDETRMINED_POSITIONS_PER_AMOUNT[@get('amount') - 1]
    if predeterminedAmount
      @positionForIndex = predeterminedAmount
    else
      @positionForIndex = @_determineTokensPositionsRandomly()


  _determineTokensPositionsRandomly: ->
    positionForIndex = []
    _.times(@get('amount'), =>
      positionForIndex.push({top: @_randomPercentageForPlacement(), left: @_randomPercentageForPlacement()})
    )
    positionForIndex

  _randomPercentageForPlacement: ->
    Math.random() * (100 - (2 * PLACEMENT_PERCENT_MARGINS)) + PLACEMENT_PERCENT_MARGINS - HALF_TOKEN_SIZE_PERCENT