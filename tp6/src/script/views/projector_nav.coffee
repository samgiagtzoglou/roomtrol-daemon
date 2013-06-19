slinky_require('../core.coffee')

Tp.ProjectorNavView = Backbone.View.extend
  initialize: () ->
    $.get 'script/templates/modules/projector_nav_module.html', (template) =>
      $.template "projector-nav-template", template
      this.render()

    _.bindAll this, 'projectorSelected'
    $("#projector-pane1").show()
    $("#projector-pane2").hide()
    $("#projector-pane3").hide()

  render: () ->
    ($.tmpl "projector-nav-template", {}).appendTo "#projector-nav"

    console.log("Setting up handlers")
    $('.left-button').click(@switchProjectorL)
    $('.middle-button').click(@switchProjectorM)
    $('.right-button').click(@switchProjectorR)

  switchProjectorL: () ->
    for j in [0..2] by 1
      Tp.devices.selected_projector[j] = false
      $("#projector-pane#{j+1}").hide()
    Tp.devices.selected_projector[0] = true
    $("#projector-pane1").show()

  switchProjectorM: () ->
    for j in [0..2] by 1
      Tp.devices.selected_projector[j] = false
      $("#projector-pane#{j+1}").hide()
    Tp.devices.selected_projector[1] = true
    $("#projector-pane2").show()

  switchProjectorR: () ->
    for j in [0..2] by 1
      Tp.devices.selected_projector[j] = false
      $("#projector-pane#{j+1}").hide()
    Tp.devices.selected_projector[2] = true
    $("#projector-pane3").show()
