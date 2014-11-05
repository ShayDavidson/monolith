class App.Markdown.CardCollectionContext extends App.Markdown.Context
  constructor: (@cardCollection, @isSimple=true) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Card
        @cardCollection.add(objectDescriptor.value)
      else
        super

  openContext: (objectDescriptor) ->
    if (@isSimple)
      throw new Error("Can't open context for #{objectDescriptor.type} inside a simple card collection")
    else if (objectDescriptor.type == App.Markdown.ObjectType.Card)
      new App.Markdown.CardContext(objectDescriptor.value)
    else
      super

