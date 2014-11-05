class Monolith.Markdown.CurrentContext extends Monolith.Markdown.Context
  constructor: (@game) ->
    @setCard = false

  foundObject: (objectDescriptor) ->
    if (objectDescriptor.type == Monolith.Markdown.ObjectType.Card)
      if (@setCard)
        throw new Error("Already set current")
      else
        @game.set("current", objectDescriptor.value)
        @setCard = true
    else
      super
