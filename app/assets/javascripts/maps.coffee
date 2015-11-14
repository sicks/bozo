# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class MapView
  constructor: ()->
    @container = $("#map")[0]
    @options = {
      nodes: {
        scaling: {
          min: 1
          max: 6
        }
      }
    }
    @nodes = new vis.DataSet( gon.nodes )
    @edges = new vis.DataSet( [] )
    @data = {
      nodes: @nodes
      edges: @edges
    }

  draw: ()->
    network = new vis.Network(@container, @data, @options)

$(document).on 'page:change', ()->
  if typeof $("#map")[0] != 'undefined'
    mapview = new MapView
    mapview.draw()


