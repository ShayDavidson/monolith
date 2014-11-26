class Monolith.Markdown.ServerContext extends Monolith.Markdown.Context
  constructor: (@server) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Card
        @server.get("installed").add(objectDescriptor.value)
      when Monolith.Markdown.ObjectType.Ice
        return
      else
        super

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Ice
        new Monolith.Markdown.CardCollectionContext(@server.get("ice"), false)
      else
        super
