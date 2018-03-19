$ ->
  $(".clear-button").click ->
    elem_id = $(this).data("for")
    $("#" + elem_id).val("")
