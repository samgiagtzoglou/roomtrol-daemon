slinky_require('../core.coffee')

Tp.ActionListView2 = Backbone.View.extend
  initialize: () ->
    $.get 'script/templates/action_list.html', (template) =>
      $.template "action-list-template", template
      Tp.server.bind "loaded", this.render
      Tp.actions2.bind "add", this.render
      Tp.actions2.bind "change", this.render
      Tp.actions2.bind "change:selection", this.selectionChanged

  render: () ->
    $('.action-list2').html ($.tmpl "action-list-template", Tp.actions2?.map (action) ->
      {
        id: action.get('id'),
        name: action.get('name'),
        icon: action.icon()
      })

    actionItemClicked = (event) ->
      console.log("Trying to select " + event.currentTarget.id)
      Tp.actions2.select event.currentTarget.id

    window.setTimeout (() =>
      $('#action-pane2 .action-list-item').unbind('click').click(actionItemClicked)), 500

  selectionChanged: () ->
    $('#action-pane2 .action-list-item').removeClass 'selected'
    $("#action-pane2 #" + Tp.actions2.selection?.id).addClass 'selected'
