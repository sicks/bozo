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
      nodes:
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
      physics:
        barnesHut:
          gravitationalConstant: -5000
          centralGravity: 0.1
          springConstant: 0.1
          springLength: 100
          damping: 0.9
          avoidOverlap: 0.9
        minVelocity: 1

    @network = new vis.Network(@container, @data, @options)

  draw: ()=>
    setTimeout @network.redraw(), 0

$(document).on 'page:change', ()->
  if typeof $("#map")[0] != 'undefined'
    if typeof window.mapview == 'undefined'
      window.mapview = new MapView
    window.mapview.draw()

