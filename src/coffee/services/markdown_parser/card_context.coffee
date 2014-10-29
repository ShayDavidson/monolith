class App.Markdown.CardContext extends App.Markdown.Context

  constructor: (line, @card) ->
    super(line)

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Card
        @card.hostedCards().add(objectDescriptor.value)
      when App.Markdown.ObjectType.Tokens
        @card.setTokens(objectDescriptor.value)
      else
        super
