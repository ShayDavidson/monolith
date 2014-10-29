class App.Markdown.CorpContext extends App.Markdown.Context
  constructor: (line, @corp) ->
    super(line)

  foundObject: (objectDescriptor) ->
    switch (objectDescriptor.type)
      when App.Markdown.ObjectType.Credits
        @corp.setCredits(objectDescriptor.value)
      when App.Markdown.ObjectType.BadPublicity
        @corp.setBadPublicity(objectDescriptor.value)
      when App.Markdown.ObjectType.HQ
        @corp.setHQ(objectDescriptor.value)
      when App.Markdown.ObjectType.Servers
        @corp.setServers(objectDescriptor.value)
      when App.Markdown.ObjectType.Scored
        @corp.setScored(objectDescriptor.value)
      else
        super

