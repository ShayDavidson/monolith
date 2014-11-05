class Monolith.Models.TokensCollection extends Backbone.Collection
  model: Monolith.Models.TokensModel

  ofType: (type) ->
    amount = @where(type: type).reduce(((sum, tokenModel) ->
      sum + tokenModel.get('amount')
    ), 0)
    new Monolith.Models.TokensModel(type: type, amount: amount)

class Monolith.Models.TokensModel extends Backbone.Model

  defaults:
    type: null # 'advancement', 'bad-publicity', 'brain-damage', 'credit', 'generic', 'tag', 'virus'
    amount: 0
