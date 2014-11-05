class Monolith.Markdown.CorpContext extends Monolith.Markdown.Context
  constructor: (line, @corp) ->
    super(line)

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when Monolith.Markdown.ObjectType.Credits
        @corp.setCredits(objectDescriptor.value)
      when Monolith.Markdown.ObjectType.BadPublicity
        @corp.setBadPublicity(objectDescriptor.value)
      when Monolith.Markdown.ObjectType.HQ
        @corp.setHQ(objectDescriptor.value)
      when Monolith.Markdown.ObjectType.Servers
        @corp.setServers(objectDescriptor.value)
      when Monolith.Markdown.ObjectType.Scored
        @corp.setScored(objectDescriptor.value)
      else
        super

