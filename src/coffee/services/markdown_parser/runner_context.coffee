class App.Markdown.RunnerContext extends App.Markdown.Context
  constructor: (@runner) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Grip
        return
      when App.Markdown.ObjectType.Heap
        return
      when App.Markdown.ObjectType.Stack
        return
      when App.Markdown.ObjectType.Installed
        return
      when App.Markdown.ObjectType.Scored
        return
      when App.Markdown.ObjectType.Credits
        @runner.set("credits", objectDescriptor.value)
      when App.Markdown.ObjectType.Tags
        @runner.set("tags", objectDescriptor.value)
      when App.Markdown.ObjectType.BrainDamage
        @runner.set("brainDamage", objectDescriptor.value)
      else
        super

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Grip
        new App.Markdown.CardCollectionContext(@runner.grip())
      when App.Markdown.ObjectType.Heap
        new App.Markdown.CardCollectionContext(@runner.heap())
      when App.Markdown.ObjectType.Stack
        new App.Markdown.CardCollectionContext(@runner.stack())
      when App.Markdown.ObjectType.Installed
        new App.Markdown.CardCollectionContext(@runner.installed(), false)
      when App.Markdown.ObjectType.Scored
        new App.Markdown.CardCollectionContext(@runner.scored())
      else
        super
