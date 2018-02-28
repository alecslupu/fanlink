$ ->
  $(".message-report-form select").change ->
    $.ajax
      context: this
      url: $(this).data("url")
      method: "PATCH"
      dataType: "json"
      data:
        message_report:
          status: $(this).val()
      error: (jqXHR) ->
        alert(jqXHR.responseJSON.error)
      success:(responseJSON) ->
        elem = $(this).next(".message-update-result")
        elem.text(responseJSON.message)
