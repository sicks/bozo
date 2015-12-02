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
      @saveLayout( @network.getPositions(), gon.map.id )
      e.preventDefault()
    @update( gon.map.id )

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

  update: ( map_id )=>
    window.poll = setTimeout ()=>
        $.ajax
          url: "/maps/#{map_id}.json"
          dataType: "json"
          success: (data)=>
            if data.updated_at > gon.map.version
              Turbolinks.visit("/maps/#{map_id}")
            @update( map_id )
      , 10000

track = ( map_id )->
  $.ajax
    url: "/maps/#{map_id}/track.json"
    dataType: 'json'
    success: (data) ->
      if gon.data.system.ccp_id != data.system.ccp_id
        $.ajax
          url: "/maps/#{map_id}/connections"
          type: 'POST'
          dataType: 'json'
          data:
            from: gon.data.system.name
            to: data.system.name
        Turbolinks.visit "/maps/#{map_id}/track"
      return
  return



$(document).on 'page:change', ()->
  clearTimeout( window.poll )
  if typeof $("#map")[0] != 'undefined'
    window.mapview = new MapView( gon.nodes, gon.edges, gon.layout )
  if typeof $("#igb")[0] != 'undefined'
    do ->
      track( gon.map.id )
      window.poll = setTimeout(arguments.callee, 10000)
      return

