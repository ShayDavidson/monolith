class Monolith.ViewModels.TokensViewCollection extends Backbone.Collection
  model: Monolith.ViewModels.TokensViewModel

  ofType: (type) ->
    amount = @where(type: type).reduce(((sum, tokenModel) ->
      sum + tokenModel.get('amount')
    ), 0)
    new Monolith.ViewModels.TokensViewModel(type: type, amount: amount)

  sample: ->
    @ofType(@first().get('type'))

class Monolith.ViewModels.TokensViewModel extends Backbone.Model

  TOKENS_IMAGE_PATH = '/images/tokens/'
  TOKENS_IMAGE_SUFFIX = '.png'

  defaults:
    type: null # 'advancement', 'bad-publicity', 'brain-damage', 'credit', 'generic', 'tag', 'virus'
    amount: 0

  imagePath: ->
    TOKENS_IMAGE_PATH + @get('type') + TOKENS_IMAGE_SUFFIX
