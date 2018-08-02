json.message_reports do
  json.array!(@message_reports) do |mr|
    json.cache! ["v3", mr] do
      json.partial! "message_report", locals: { message_report: mr }
    end
  end
end
