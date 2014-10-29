class App.Markdown.CardCollectionContext extends App.Markdown.Context
  constructor: (@cardCollection) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Card
        @cardCollection.add(objectDescriptor.value)
      else
        super
