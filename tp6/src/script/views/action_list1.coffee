slinky_require('../core.coffee')

Tp.ActionListView1 = Backbone.View.extend
  initialize: () ->
    $.get 'script/templates/action_list.html', (template) =>
      $.template "action-list-template", template
      Tp.server.bind "loaded", this.render
      Tp.actions1.bind "add", this.render
      Tp.actions1.bind "change", this.render
      Tp.actions1.bind "change:selection", this.selectionChanged

  render: () ->
    $('.action-list1').html ($.tmpl "action-list-template", Tp.actions1?.map (action) ->
      {
        id: action.get('id'),
        name: action.get('name'),
        icon: action.icon()
      })

    actionItemClicked = (event) ->
      console.log("Trying to select " + event.currentTarget.id)
      Tp.actions1.select event.currentTarget.id

    window.setTimeout (() =>
      $('.action-list-item').unbind('click').click(actionItemClicked)), 500

  selectionChanged: () ->
    $('.action-list-item').removeClass 'selected'
    $("#" + Tp.actions1.selection?.id).addClass 'selected'
