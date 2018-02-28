$ ->
  $(".post-report-form select").change ->
    $.ajax
      context: this
      url: $(this).data("url")
      method: "PATCH"
      dataType: "json"
      data:
        post_report:
          status: $(this).val()
      error: (jqXHR) ->
        alert(jqXHR.responseJSON.error)
      success:(responseJSON) ->
        elem = $(this).next(".post-update-result")
        elem.text(responseJSON.message)
