class App.Markdown.CurrentContext extends App.Markdown.Context
  constructor: (@game) ->
    @setCard = false

  foundObject: (objectDescriptor) ->
    if (objectDescriptor.type == App.Markdown.ObjectType.Card)
      if (@setCard)
        throw new Error("Already set current")
      else
        @game.set("current", objectDescriptor.value)
        @setCard = true
    else
      super
