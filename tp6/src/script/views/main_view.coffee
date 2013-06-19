slinky_require('projector_pane1.coffee')
slinky_require('projector_pane2.coffee')
slinky_require('action_list.coffee')
slinky_require('context_view.coffee')

$(document).ready () ->
  Tp.projectorPane1 = new Tp.ProjectorPaneView1
  Tp.projectorPane2 = new Tp.ProjectorPaneView2
  Tp.actionListView1 = new Tp.ActionListView1
  Tp.actionListView2 = new Tp.ActionListView2
