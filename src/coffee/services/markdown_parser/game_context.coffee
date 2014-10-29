class App.Markdown.GameContext extends App.Markdown.Context
  constructor: (@game) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Runner
        @game.runner()
        @game.runner().setIdentity(objectDescriptor.value) if objectDescriptor.value?
      when App.Markdown.ObjectType.Corp
        @game.corp()
        @game.corp().setIdentity(objectDescriptor.value) if objectDescriptor.value?

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Runner
        new App.Markdown.RunnerContext(@game.runner())

