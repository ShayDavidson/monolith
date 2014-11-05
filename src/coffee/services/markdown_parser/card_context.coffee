class Monolith.Markdown.CardContext extends Monolith.Markdown.Context

  constructor: (@card) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Card
        @card.hostedCards().add(objectDescriptor.value)
      when Monolith.Markdown.ObjectType.Credits
        @card.set("credits", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.VirusToken
        @card.set("virusTokens", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.AdvancedmentToken
        @card.set("advancementTokens", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.GenericToken
        @card.set("genericTokens", objectDescriptor.value)
      else
        super

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Card
        new Monolith.Markdown.CardContext(objectDescriptor.value)
