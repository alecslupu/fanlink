$ ->
  console.log("loading")
  $(".translate-button a").click ->
    $(".post-body").fadeIn(1000)
    $(this).parent().hide()