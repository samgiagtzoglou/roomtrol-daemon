slinky_require('../main.coffee')

Tp.Action1 = Backbone.Model.extend
  select: ->
    this.get('source')?.select(0)
    # TODO: other stuff, like prompting for projector and switching
    # the context view
  icon: ->
    this.get('icon') or this.get('source')?.get('icon')

Tp.Action2 = Backbone.Model.extend
  select: ->
    this.get('source')?.select(1)
  icon: ->
    this.get('icon') or this.get('source')?.get('icon')

Tp.ActionController1 = Backbone.Collection.extend
  model: Tp.Action1
  select: (id) ->
    action = this.get(id)
    if action
      Tp.log("Selecting %s", action)
      action.select()
      @selection = action
      this.trigger("change:selection")

Tp.ActionController2 = Backbone.Collection.extend
  model: Tp.Action2
  select: (id) ->
    action = this.get(id)
    if action
      Tp.log("Selecting %s", action)
      action.select()
      @selection = action
      this.trigger("change:selection")


Tp.actions1 = new Tp.ActionController1
Tp.actions2 = new Tp.ActionController2
