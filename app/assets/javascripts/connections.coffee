# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '.swap', (e)->
  id = $(e.target).data("connection")
  from_value = $("#connection_#{id} #connection_from").val()
  to_value = $("#connection_#{id} #connection_to").val()
  $("#connection_#{id} #connection_from").val(to_value)
  $("#connection_#{id} #connection_to").val(from_value)
  false
