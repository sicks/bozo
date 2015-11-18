# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class MapView
  constructor: ()->
    @container = $("#map")[0]

    @data =
      nodes: new vis.DataSet( gon.nodes )
      edges: new vis.DataSet( gon.edges )

    @options =
      layout:
        randomSeed: gon.seed
      nodes:
        font:
          color: '#EFEFEF'
        mass: 1
        scaling:
          min: 1
          max: 6
          label:
            enabled: true
      edges:
        arrows:
          to:
            enabled: true
            scaleFactor: 0.25
        scaling:
          min: 1
          max: 12
          label:
            enabled: false
        font:
          color: '#F9F9F9'
          strokeWidth: 0
          align: 'top'
      interaction:
        hoverConnectedEdges: false
        selectConnectedEdges: false
      physics:
        barnesHut:
          gravitationalConstant: -5000
          centralGravity: 0.1
          springConstant: 0.1
          springLength: 25
          damping: 1
          avoidOverlap: 0.9
        minVelocity: 2

  network: ()=>
    @net ?= new vis.Network(@container, @data, @options)
    @net.on 'click', (e)=>
      if e.nodes.length == 0 && e.edges.length == 1
        @selectedItem("connection",  e.edges[0] )
      else if e.nodes.length == 1 && e.edges.length == 0
        @selectedItem("system", e.nodes[0] )
  selectedItem: ( type, id )->
    $(".selected-item .content").removeClass("active")
    $("##{type}_#{id}").addClass("active")

$(document).on 'page:change', ()->
  if typeof $("#map")[0] != 'undefined'
    window.mapview = new MapView
    window.mapview.network()

