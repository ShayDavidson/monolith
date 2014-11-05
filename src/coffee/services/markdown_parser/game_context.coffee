class Monolith.Markdown.GameContext extends Monolith.Markdown.Context
  constructor: (@game) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Runner
        @game.runner()
        @game.runner().setIdentity(objectDescriptor.value) if objectDescriptor.value?
      when Monolith.Markdown.ObjectType.Corp
        @game.corp()
        @game.corp().setIdentity(objectDescriptor.value) if objectDescriptor.value?
      when Monolith.Markdown.ObjectType.Current
        return

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Runner
        new Monolith.Markdown.RunnerContext(@game.runner())
      when Monolith.Markdown.ObjectType.Current
        new Monolith.Markdown.CurrentContext(@game)

