class Monolith.Markdown.CardCollectionContext extends Monolith.Markdown.Context
  constructor: (@cardCollection, @isSimple=true) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Card
        @cardCollection.add(objectDescriptor.value)
      else
        super

  openContext: (objectDescriptor) ->
    if (@isSimple)
      throw new Error("Can't open context for #{objectDescriptor.type} inside a simple card collection")
    else if (objectDescriptor.type == Monolith.Markdown.ObjectType.Card)
      new Monolith.Markdown.CardContext(objectDescriptor.value)
    else
      super

