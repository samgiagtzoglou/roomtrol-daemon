slinky_require('../core.coffee')

Tp.ProjectorNavView = Backbone.View.extend
  initialize: () ->
    $.get 'script/templates/modules/projector_nav_module.html', (template) =>
      $.template "projector-nav-template", template
      this.render()

    _.bindAll this, 'projectorSelected'
    $("#projector-pane1").hide()
    $("#projector-pane2").hide()
    $("#projector-pane3").hide()

  render: () ->
    ($.tmpl "projector-nav-template", {}).appendTo "#projector-nav"

    console.log("Setting up handlers")
    $('.left-button').click(@leftSelected)
    $('.middle-button').click(@middleSelected)
    $('.right-button').click(@rightSelected)

  leftSelected: () ->
    $("#projector-pane1").show()
    $("#projector-pane2").hide()
    $("#projector-pane3").hide()

  middleSelected: () ->
    $("#projector-pane1").hide()
    $("#projector-pane2").show()
    $("#projector-pane3").hide()

  rightSelected: () ->
    $("#projector-pane1").hide()
    $("#projector-pane2").hide()
    $("#projector-pane3").show()
