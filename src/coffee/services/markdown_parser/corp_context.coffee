class Monolith.Markdown.CorpContext extends Monolith.Markdown.Context
  constructor: (@corp) ->

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Credits
        @corp.set("credits", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.BadPublicity
        @corp.set("badPublicity", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.RND
        @corp.set("rndCount", objectDescriptor.value)
      when Monolith.Markdown.ObjectType.HQ
        return
      when Monolith.Markdown.ObjectType.Archives
        return
      when Monolith.Markdown.ObjectType.Remote
        @corp.remotes().add(new Monolith.Models.Server())
      when Monolith.Markdown.ObjectType.Scored
        return
      else
        super

  openContext: (objectDescriptor) ->
    switch(objectDescriptor.type)
      when Monolith.Markdown.ObjectType.RND
        new Monolith.Markdown.ServerContext(@corp.rnd())
      when Monolith.Markdown.ObjectType.HQ
        new Monolith.Markdown.ServerContext(@corp.hq())
      when Monolith.Markdown.ObjectType.Archives
        new Monolith.Markdown.ServerContext(@corp.archives())
      when Monolith.Markdown.ObjectType.Remote
        new Monolith.Markdown.ServerContext(@corp.remotes().last())
      when Monolith.Markdown.ObjectType.Scored
        new Monolith.Markdown.CardCollectionContext(@corp.scored())
      else
        super
