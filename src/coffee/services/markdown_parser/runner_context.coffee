class App.Markdown.RunnerContext extends App.Markdown.Context
  constructor: (@runner) ->

  foundObject: (objectDescriptor) ->
    #switch (objectDescriptor.type)
      #when App.Markdown.ObjectType.Credits
        #@runner.setCredits(objectDescriptor.value)
      #when App.Markdown.ObjectType.Tags
        #@runner.setTags(objectDescriptor.value)
      #when App.Markdown.ObjectType.BrainDamage
        #@runner.setBrainDamage(objectDescriptor.value)
      #when App.Markdown.ObjectType.Grip
        #@runner.setGrip(objectDescriptor.value)
      #when App.Markdown.ObjectType.Installed
        #@runner.setInstalled(objectDescriptor.value)
      #when App.Markdown.ObjectType.Scored
        #@runner.setScored(objectDescriptor.value)
      #else
        #super
