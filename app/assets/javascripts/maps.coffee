# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class MapView
  constructor: ( nodes, edges, @layout )->
    @container = $("#map")[0]

    @data =
      nodes: new vis.DataSet( nodes )
      edges: new vis.DataSet( edges )

    @options =
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

    @network = new vis.Network(@container, @data, @options)
    @bindEvents()
    @applyLayout( @layout, 10 )

  bindEvents: ()=>
    @network.on 'selectEdge', (e)=>
      @selectedItem("connection",  e.edges[0] )
    @network.on 'selectNode', (e)=>
      @selectedItem("system", e.nodes[0] )
    $(document).on 'click', '#seed', (e)=>
      @saveLayout( @network.getPositions(), $(e.target).data("map") )
      e.preventDefault()

  selectedItem: ( type, id )->
    $(".selected-item .content").removeClass("active")
    $("##{type}_#{id}").addClass("active")

  saveLayout: ( positions, map_id )->
    $.ajax
      url: "/maps/#{map_id}"
      type: "PUT"
      data: { id: map_id, map: { layout: JSON.stringify(positions) } }
      dataType: "json"
      success: (resp)->
        console.dir(resp)

  applyLayout: ( positions, i )=>
    for nodeId, coords of positions
      @network.moveNode( nodeId, coords.x, coords.y )
    @network.stabilize()
    if i > 0
      setTimeout ()=>
          @applyLayout( positions, i -= 1 )
        , 0

$(document).on 'page:change', ()->
  if typeof $("#map")[0] != 'undefined'
    window.mapview = new MapView( gon.nodes, gon.edges, gon.layout )

