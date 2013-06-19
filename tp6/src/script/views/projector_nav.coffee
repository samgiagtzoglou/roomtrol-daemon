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
    $(".left-button").addClass("selected")

  switchProjectorL: () ->
    for j in [0..2] by 1
      Tp.devices.selected_projector[j] = false
      $("#projector-pane#{j+1}").hide()
    Tp.devices.selected_projector[0] = true
    $("#projector-pane1").show()
    $(".right-button").removeClass("selected")
    $(".middle-button").removeClass("selected")
    $(".left-button").addClass("selected")
    currSource = Tp.room.get('source1').id
    Tp.actions.map (action) ->
      if currSource and action.attributes.source.id == currSource
        $("##{action.get('id')}").addClass("selected")
      else
        $("##{action.get('id')}").removeClass("selected")

  switchProjectorM: () ->
    for j in [0..2] by 1
      Tp.devices.selected_projector[j] = false
      $("#projector-pane#{j+1}").hide()
    Tp.devices.selected_projector[1] = true
    $("#projector-pane2").show()
    $(".right-button").removeClass("selected")
    $(".left-button").removeClass("selected")
    $(".middle-button").addClass("selected")
    currSource = Tp.room.get('source2').id
    Tp.actions.map (action) ->
      if currSource and action.attributes.source.id == currSource
        $("##{action.get('id')}").addClass("selected")
      else
        $("##{action.get('id')}").removeClass("selected")

  switchProjectorR: () ->
    for j in [0..2] by 1
      Tp.devices.selected_projector[j] = false
      $("#projector-pane#{j+1}").hide()
    Tp.devices.selected_projector[2] = true
    $("#projector-pane3").show()
    $(".left-button").removeClass("selected")
    $(".middle-button").removeClass("selected")
    $(".right-button").addClass("selected")
    currSource = Tp.room.get('source3').id
    Tp.actions.map (action) ->
      if currSource and action.attributes.source.id == currSource
        $("##{action.get('id')}").addClass("selected")
      else
        $("##{action.get('id')}").removeClass("selected")
