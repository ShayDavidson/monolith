class Monolith.Models.TokensCollection extends Backbone.Collection
  model: Monolith.Models.TokensModel

  ofType: (type) ->
    amount = @where(type: type).reduce(((sum, tokenModel) ->
      sum + tokenModel.get('amount')
    ), 0)
    new Monolith.Models.TokensModel(type: type, amount: amount)

class Monolith.Models.TokensModel extends Backbone.Model

  TOKENS_IMAGE_PATH = '/images/tokens/'
  TOKENS_IMAGE_SUFFIX = '.png'

  defaults:
    type: null # 'advancement', 'bad-publicity', 'brain-damage', 'credit', 'generic', 'tag', 'virus'
    amount: 0

  imagePath: ->
    TOKENS_IMAGE_PATH + @get('type') + TOKENS_IMAGE_SUFFIX
