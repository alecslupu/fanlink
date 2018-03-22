$ ->
  $(".translate-button a").click ->
    $(this).closest(".translated-field").find(".field-unit--text").each ->
      $(this).fadeIn(1000)
    $(this).parent().hide()
