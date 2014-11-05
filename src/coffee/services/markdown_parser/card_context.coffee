class App.Markdown.CardContext extends App.Markdown.Context

  constructor: (@card) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Card
        @card.hostedCards().add(objectDescriptor.value)
      when App.Markdown.ObjectType.Credits
        @card.set("credits", objectDescriptor.value)
      when App.Markdown.ObjectType.VirusToken
        @card.set("virusTokens", objectDescriptor.value)
      when App.Markdown.ObjectType.AdvancedmentToken
        @card.set("advancementTokens", objectDescriptor.value)
      when App.Markdown.ObjectType.GenericToken
        @card.set("genericTokens", objectDescriptor.value)
      else
        super

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Card
        new App.Markdown.CardContext(objectDescriptor.value)
