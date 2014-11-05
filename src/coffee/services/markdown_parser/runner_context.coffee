class Monolith.Markdown.RunnerContext extends Monolith.Markdown.Context
  constructor: (@runner) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Grip
        return
      when Monolith.Markdown.ObjectType.Heap
        return
      when Monolith.Markdown.ObjectType.Stack
        return
      when Monolith.Markdown.ObjectType.Installed
        return
      when Monolith.Markdown.ObjectType.Scored
        return
      when Monolith.Markdown.ObjectType.Credits
        @runner.set("credits", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.Tags
        @runner.set("tags", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.BrainDamage
        @runner.set("brainDamage", objectDescriptor.value)
      else
        super

  openContext: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Grip
        new Monolith.Markdown.CardCollectionContext(@runner.grip())
      when Monolith.Markdown.ObjectType.Heap
        new Monolith.Markdown.CardCollectionContext(@runner.heap())
      when Monolith.Markdown.ObjectType.Stack
        new Monolith.Markdown.CardCollectionContext(@runner.stack())
      when Monolith.Markdown.ObjectType.Installed
        new Monolith.Markdown.CardCollectionContext(@runner.installed(), false)
      when Monolith.Markdown.ObjectType.Scored
        new Monolith.Markdown.CardCollectionContext(@runner.scored())
      else
        super
